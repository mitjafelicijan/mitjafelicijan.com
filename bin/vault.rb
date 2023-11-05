require 'nokogiri'
require 'net/http'
require 'uri'

url = "https://mitjafelicijan.fra1.digitaloceanspaces.com/"

def truncate_filename(filename, max_length)
  return filename if filename.length <= max_length

  file_extension = filename.split('.').last
  "#{filename[0...max_length - file_extension.length - 5]}….#{file_extension}"
end

uri = URI(url)
response = Net::HTTP.get_response(uri)

if response.is_a?(Net::HTTPSuccess)
  xml_data = response.body
  root = Nokogiri::XML(xml_data)

  root.remove_namespaces!
  tree = {}

  root.xpath("//Contents").each do |content|
    key = content.xpath("Key").text
    parts = key.split("/")
    node = tree
    parts.each do |part|
      next if part.empty?
      node[part] ||= {}
      node = node[part]
    end
  end

  def tree_to_md(tree, url, indent = 0, path = "")
    md = ""
    tree.each do |k, v|
      if v.empty? # If the node is empty, it's a file
        file_url = "#{url}#{path}#{k}"
        file_name = truncate_filename(k, 500)
        md += "#{"  " * indent}- [#{file_name}](#{file_url})\n"
      else # If the node has children, it's a directory
        md += "#{"  " * indent}- #{k}\n"
        md += tree_to_md(v, url, indent + 1, "#{path}#{k}/")
      end
    end
    md
  end

  md = tree_to_md(tree, url)
  puts md

  File.open("_layouts/vault.md", "r") do |file|
    content = file.read
    new_content = content.gsub("{CONTENT}", md)
    File.open("vault.md", "w") { |f| f.write(new_content) }
  end
else
  puts "Failed to fetch XML data. Status code: #{response.code}"
end
