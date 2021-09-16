<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
  <xsl:template match="/">

    <html>

      <head>

        <meta charset="utf-8" />
        <meta name="theme-color" content="#ffffff" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />

        <link rel="manifest" href="/manifest.json?v=1" />

        <meta name="theme-color" content="#f4ca16" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;700&amp;display=swap" rel="stylesheet" type='text/css' />

        <style>
          :root {
            --base-document-width: 500px;
          }

          * {
            box-sizing: border-box;
            background-color: transparent;
            margin: 0;
            padding: 0;
            border: 0;
            list-style-type: none;
            outline: none;
            text-decoration: none;
            position: relative;
            box-shadow: none;

            -moz-osx-font-smoothing: grayscale !important;
            text-rendering: optimizeLegibility !important;
            -webkit-font-smoothing: antialiased !important;
          }

          body {
            font-family: "IBM Plex Sans", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 14px;
            line-height: 140%;
          }

          h1 { font-size: 140%; }
          h2 { font-size: 130%; }
          h3 { font-size: 120%; }

          .fixed {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            width: 100%;
            background: #f4ca16;
            z-index: 2;
            border-bottom: 0px solid #eee;
          }

          header {
            max-width: var(--base-document-width);
            margin: 0 auto;
            padding: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
          }

          header figure img {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 100%;
          }

          header .meta {
            flex-grow: 1;
          }

          header .subscribe span {
            background: #ffffff;
            border: 2px solid #eaae3c;
            padding: 8px 15px;
            border-radius: 50px;
            color: #eaae3c;
            font-weight: 700;
            cursor: pointer;
            text-transform: uppercase;
            font-size: 80%;
          }

          header .subscribe span:hover {
            background-color: #eaae3c;
            color: #fff;
          }

          main {
            max-width: var(--base-document-width);
            margin: 0 auto;
            padding: 20px;
            padding-top: 120px;
          }

          article {
            border: 1px solid #eee;
            margin-block-end: 20px;
            max-width: 100%;

            border-radius: 5px;
            overflow: hidden;
          }

          article figure img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
          }

          article section {
            padding: 10px 15px;
          }

          article section p {
            margin-block-end: 15px;
            font-size: 120%;
          }

          article section .meta {
            display: flex;
            gap: 5px;
            align-items: center;
            color: #808080;
            font-weight: 500;
          }

          article section .meta img {
            width: 15px;
            height: 15px;
            object-fit: cover;
            border-radius: 100%;
          }

        </style>

      </head>

      <body>

        <div class="fixed">
          <header>
            <figure>
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="rss/channel/image/url" />
                </xsl:attribute>
              </img>
            </figure>
            <div class="meta">
              <h1><xsl:value-of select="rss/channel/title" /></h1>
              <p><xsl:value-of select="rss/channel/link" /></p>
            </div>
          </header>
        </div>

        <main>

          <xsl:for-each select="rss/channel/item">
            <xsl:sort select="rid" data-type="number" order="descending" />

            <article>

              <xsl:if test="enclosure/@url">
                <figure>
                  <a target="_blank">
                    <xsl:attribute name="href">
                      <xsl:value-of select="enclosure/@url" />
                    </xsl:attribute>

                    <img>
                      <xsl:attribute name="src">
                        <xsl:value-of select="enclosure/@url" />
                      </xsl:attribute>
                    </img>
                  </a>
                </figure>
              </xsl:if>

              <section>
                <xsl:if test="description">
                  <p><xsl:value-of select="description" /></p>
                </xsl:if>

                <xsl:if test="pubDate">
                  <div class="meta">
                    <img>
                      <xsl:attribute name="src">
                        <xsl:value-of select="/rss/channel/image/url" />
                      </xsl:attribute>
                    </img>

                    <time class="timeago">
                      <xsl:attribute name="datetime">
                        <xsl:value-of select="pubDate" />
                      </xsl:attribute>
                      <xsl:value-of select="pubDate" />
                    </time>
                  </div>
                </xsl:if>
              </section>

            </article>
          </xsl:for-each>

        </main>

        <script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>
        <script src="https://unpkg.com/dayjs@1.8.21/plugin/relativeTime.js"></script>
        <script>

            dayjs.extend(window.dayjs_plugin_relativeTime);
            document.querySelectorAll('time').forEach(element => {
              element.innerText = dayjs(element.getAttribute('datetime')).fromNow();
            });

            function replaceURLs(message) {
              var urlRegex = /(((https?:\/\/)|(www\.))[^\s]+)/g;
              return message.replace(urlRegex, function (url) {
                return `<a>@@@@${url}</a>`;
              });
            }

            document.querySelectorAll('article p').forEach(element => {
              // element.innerHTML = replaceURLs(element.innerHTML);
              console.log(replaceURLs(element.innerHTML));
            });

        </script>

      </body>
    </html>

  </xsl:template>
</xsl:stylesheet>

