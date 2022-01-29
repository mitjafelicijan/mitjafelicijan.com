<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">

    <html>

      <head>

        <meta charset="utf-8" />
        <meta name="theme-color" content="#ffffff" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />

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
            font-family: system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 14px;
            line-height: 140%;
            background: #fff;
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
            background: #fff;
            z-index: 2;
            border-bottom: 1px solid #eee;
          }

          header {
            max-width: var(--base-document-width);
            margin: 0 auto;
            padding: 20px;
          }

          header .meta {
            flex-grow: 1;
          }

          header a {
            color: #111;
          }

          main {
            max-width: var(--base-document-width);
            margin: 0 auto;
            padding: 20px;
            padding-top: 110px;
          }

          article {
            border: 1px solid #eee;
            margin-block-end: 20px;
            max-width: 100%;

            border-radius: 10px;
            overflow: hidden;
          }

          article figure img {
            width: 100%;
            max-height: 250px;
            object-fit: cover;
          }

          article section {
            padding: 15px;
          }

          article section p {
            margin-block-end: 15px;
            font-size: 120%;
          }

          article section .meta {
            color: #808080;
            font-weight: 500;
          }


          @media (prefers-color-scheme: dark) {
            body, .fixed {
              background: #222;
              color: #fff;
              border-color: #444;
            }

            header a {
              color: #fff;
            }

            article {
              border-color: #444;
            }
          }

        </style>

      </head>

      <body>

        <div class="fixed">
          <header>
            <div class="meta">
              <h1><xsl:value-of select="rss/channel/title" /></h1>
              <p>
                <a target="_blank">
                  
                  <xsl:attribute name="href">
                    <xsl:value-of select="rss/channel/link" />
                  </xsl:attribute>

                  <xsl:value-of select="rss/channel/link" />
                </a>
              </p>
            </div>
          </header>
        </div>

        <main>

          <xsl:for-each select="rss/channel/item">
            <xsl:sort select="guid" data-type="number" order="ascending" />

            <article>

              <xsl:if test="enclosure/@url">
                <figure>
                  <img>
                    <xsl:attribute name="src">
                      <xsl:value-of select="enclosure/@url" />
                    </xsl:attribute>
                  </img>
                </figure>
              </xsl:if>

              <section>
                <xsl:if test="description">
                  <p><xsl:value-of select="description" /></p>
                </xsl:if>

                <xsl:if test="pubDate">
                  <div class="meta">
                    <time>
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

      </body>
    </html>

  </xsl:template>
</xsl:stylesheet>
