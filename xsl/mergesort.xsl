<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.0">

  <xsl:template match="/">
    <html>
      <head>
        <title>Mergesort madness</title>
      </head>
      <body>
        <h1>Previous</h1>
        <xsl:apply-templates />

        <h1>Sorted</h1>
        <xsl:variable name='sorted'>
          <xsl:call-template name='mergesort'>
            <xsl:with-param name='lst'>
              <xsl:copy-of select='list' />
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>

        <xsl:apply-templates select='exsl:node-set($sorted)/list' />
      </body>
    </html>
  </xsl:template>

  <xsl:template name='merge'>
    <xsl:param name='a' />
    <xsl:param name='b' />

    <xsl:choose>
      <xsl:when test='count(exsl:node-set($a)/list/element)=0'>
        <xsl:copy-of select='exsl:node-set($b)/list' />
      </xsl:when>
      <xsl:when test='count(exsl:node-set($b)/list/element)=0'>
        <xsl:copy-of select='exsl:node-set($a)/list' />
      </xsl:when>
      <xsl:when test='exsl:node-set($a)/list/*[1]/@value &lt;
          exsl:node-set($b)/list/*[1]/@value'>
        <xsl:variable name='r'>
          <xsl:call-template name='merge'>
            <xsl:with-param name='a'>
              <list><xsl:copy-of
                select='exsl:node-set($a)/list/*[count(preceding-sibling::*) &gt; 0]' />
              </list>
            </xsl:with-param>
            <xsl:with-param name='b' select='exsl:node-set($b)' />
          </xsl:call-template>
        </xsl:variable>
        <list>
          <xsl:copy-of select='exsl:node-set($a)/list/element[1]' />
          <xsl:copy-of select='exsl:node-set($r)/list/element' />
        </list>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name='r'>
          <xsl:call-template name='merge'>
            <xsl:with-param name='a' select='exsl:node-set($a)' />
            <xsl:with-param name='b'>
              <list><xsl:copy-of
                select='exsl:node-set($b)/list/*[count(preceding-sibling::*) &gt; 0]' />
              </list>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <list>
          <xsl:copy-of select='exsl:node-set($b)/list/element[1]' />
          <xsl:copy-of select='exsl:node-set($r)/list/element' />
        </list>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name='mergesort'>
    <xsl:param name='lst' />
    <xsl:variable name='size' select='count(exsl:node-set($lst)/list/element)' />
    <xsl:choose>
      <xsl:when test='$size &lt; 2'>
        <xsl:copy-of select='exsl:node-set($lst)' />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name='merge'>
          <xsl:with-param name='a'>
            <xsl:call-template name='mergesort'>
              <xsl:with-param name='lst'>
                <list><xsl:copy-of
                  select='exsl:node-set($lst)/list/*[count(following-sibling::*)
                    &gt;= $size div 2]' />
                </list>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
          <xsl:with-param name='b'>
            <xsl:call-template name='mergesort'>
              <xsl:with-param name='lst'>
                <list><xsl:copy-of
                  select='exsl:node-set($lst)/list/*[count(following-sibling::*)
                    &lt; $size div 2]' />
                </list>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match='list'>
    <ol><xsl:apply-templates /></ol>
  </xsl:template>

  <xsl:template match='element'>
    <li><xsl:value-of select='@value' /></li>
  </xsl:template>
</xsl:stylesheet>
