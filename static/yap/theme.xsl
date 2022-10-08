<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">

    <html>

      <head>

        <meta charset="utf-8" />
        <meta name="theme-color" content="#ffffff" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />

        <title>Microblog - Mitja Felicijan</title>
        <link rel="icon" type="image/gif" href="/general/favicon.gif" />

        <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet" />

        <style>
          .container-blog {
            max-width: 700px;
          }
        </style>

        <script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
        <script>
          window.addEventListener('load', () => {
            document.querySelectorAll('time').forEach(el => {
              const formattedDate = dayjs(el.getAttribute('datetime')).format('dddd, MMMM D, YYYY h:mm A');
              el.innerText = formattedDate;
            });
          });
        </script>

      </head>

      <body>

        <header class="container-blog mx-auto px-6 md:p-0">
          <div class="flex py-4 mt-4 mb-6 items-center gap-2">
            <h1>
              <a href="/" class="text-xl font-bold hover:bg-yellow-100">
                <xsl:value-of select="rss/channel/title" />
              </a>
            </h1>
          </div>
        </header>

        <main class="container-blog mx-auto px-6 md:p-0 mb-32">

          <xsl:for-each select="rss/channel/item">
            <xsl:sort select="guid" data-type="number" order="descending" />

            <article class="flex flex-col md:flex-row gap-4 mb-10">

              <xsl:if test="enclosure/@url">
                <a class="w-full md:w-80" target="_blank">
                  <xsl:attribute name="href">
                    <xsl:value-of select="enclosure/@url" />
                  </xsl:attribute>

                  <img class="rounded w-full object-contain md:object-fill">
                    <xsl:attribute name="src">
                      <xsl:value-of select="enclosure/@url" />
                    </xsl:attribute>
                  </img>
                </a>
              </xsl:if>

              <section>
                <xsl:if test="pubDate">
                  <div class="text-gray-400 text-xs font-medium mb-1">
                    <time>
                      <xsl:attribute name="datetime">
                        <xsl:value-of select="pubDate" />
                      </xsl:attribute>
                      <xsl:value-of select="pubDate" />
                    </time>
                  </div>
                </xsl:if>

                <xsl:if test="description">
                  <div class="description">
                    <xsl:value-of select="description" />
                  </div>
                </xsl:if>
              </section>

            </article>
          </xsl:for-each>

        </main>

      </body>
    </html>

  </xsl:template>
</xsl:stylesheet>
