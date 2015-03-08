<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.0">

  <xsl:template match="/">
    <xsl:call-template name='mergesort'>
      <xsl:with-param name='lst'>
        <xsl:copy-of select='list' />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name='merge'>
    <xsl:param name='a' />
    <xsl:param name='b' />

    <xsl:choose>
      <xsl:when test='not(exsl:node-set($a)/element)'>
        <xsl:copy-of select='exsl:node-set($b)' />
      </xsl:when>
      <xsl:when test='not(exsl:node-set($b)/element)'>
        <xsl:copy-of select='exsl:node-set($a)' />
      </xsl:when>
      <xsl:when test='exsl:node-set($a)/element[1]/@value &lt; exsl:node-set($b)/element[1]/@value'>
        <xsl:copy-of select='exsl:node-set($a)/element[1]' />
        <xsl:call-template name='merge'>
          <xsl:with-param name='a'>
            <xsl:copy-of select='exsl:node-set($a)/element[position() &gt; 1]' />
          </xsl:with-param>
          <xsl:with-param name='b' select='exsl:node-set($b)' />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select='exsl:node-set($b)/element[1]' />
        <xsl:call-template name='merge'>
          <xsl:with-param name='a' select='exsl:node-set($a)' />
          <xsl:with-param name='b'>
              <xsl:copy-of select='exsl:node-set($b)/element[position() &gt; 1]' />
          </xsl:with-param>
        </xsl:call-template>
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
        <xsl:variable name='firsthalf'>
          <xsl:call-template name='mergesort'>
            <xsl:with-param name='lst'>
              <list>
                <xsl:copy-of select='exsl:node-set($lst)/list/element[position() &lt;= $size div 2]' />
              </list>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name='secondhalf'>
          <xsl:call-template name='mergesort'>
            <xsl:with-param name='lst'>
              <list>
                <xsl:copy-of select='exsl:node-set($lst)/list/element[position() &gt; $size div 2]' />
              </list>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:variable>

        <list>
          <xsl:call-template name='merge'>
            <xsl:with-param name='a'>
              <xsl:copy-of select='exsl:node-set($firsthalf)/list/element' />
            </xsl:with-param>
            <xsl:with-param name='b'>
              <xsl:copy-of select='exsl:node-set($secondhalf)/list/element' />
            </xsl:with-param>
          </xsl:call-template>
        </list>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
