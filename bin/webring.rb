require "erb"
require "htmlentities"
require "open-uri"
require "simple-rss"

summary_max_length = 320

feeds = [
  "https://blog.regehr.org/feed",
  "https://www.neilhenning.dev/index.xml",
  "https://drewdevault.com/blog/index.xml",
  "https://offbeatpursuit.com/blog/index.rss",
  "https://mirzapandzo.com/rss.xml",
  "https://journal.valeriansaliou.name/rss/",
  "https://neil.computer/rss/",
  "https://michael.stapelberg.ch/feed.xml",
  "https://utcc.utoronto.ca/~cks/space/blog/?atom",
  "https://szymonkaliski.com/feed.xml"
]

out_html = ""
decoder = HTMLEntities.new

feeds.each do |feed_url|
  begin
    rss_content = URI.open(feed_url).read
    rss = SimpleRSS.parse(rss_content)

    first = rss.items.first
    author = rss.channel.title
    website = rss.channel.link.gsub(%r{</?[^>]+?>}, '')
    title = first.title
    link = first.link

    description = first.description
    summary = description
    content = first.content

    if not summary
      summary = content
    end

    summary.force_encoding("UTF-8")
    summary = decoder.decode(summary)
                .gsub(%r{</?[^>]+?>}, '')
                .gsub(/\s{2,}/, ' ')
                .gsub("\n", ' ')

    if summary.length > summary_max_length
      summary = "#{summary[0...summary_max_length]}..."
    end

    template = ERB.new <<-EOF
      <li>
        <div><a href="<%= link %>" target="_blank" rel="noopener"><%= title %></a> — <%= author %></div>
        <div><%= summary %></div>
      </li>
    EOF

    partial = template.result(binding)
    out_html.concat(partial)

    puts "Feed: #{author}"
    puts "Title: #{title}"
    puts "Link: #{link}"
    puts "Summary: #{summary}"
    puts
  rescue OpenURI::HTTPError => e
    puts "Failed to fetch #{feed_url}: #{e.message}"
  rescue SimpleRSSError => e
    puts "Failed to parse #{feed_url}: #{e.message}"
  end
end

template = ERB.new <<-EOF
  <h2>Posts from blogs I follow around the net</h2>
  <ul><%= out_html %></ul>
EOF
out_html = template.result(binding)
File.write("_includes/webring.html", out_html)
