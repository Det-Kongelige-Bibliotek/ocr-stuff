<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="2">

  <xsl:template match="/">
    <xsl:apply-templates select="Layout"/>
  </xsl:template>

  <xsl:template match="Layout">
    <div>
      <xsl:apply-templates select="Page"/>
    </div>
  </xsl:template>

  <xsl:template match="Page">
    <div>
      <p>Here comes the text</p>
    </div>
  </xsl:template>
</xsl:transform>