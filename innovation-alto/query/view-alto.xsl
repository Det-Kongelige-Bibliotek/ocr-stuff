<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:h="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="h"
		version="2">

  <xsl:output method="xml"
	      encoding="UTF-8"
	      indent="yes"/>

  <xsl:template match="/alto">
    <h:div>
      <xsl:apply-templates select="Layout"/>
    </h:div>
  </xsl:template>

  <xsl:template match="Layout">
    <h:div>
      <strong>shit</strong>
      <xsl:apply-templates select="Page"/>
    </h:div>
  </xsl:template>

  <xsl:template match="Page">
    <h:div>
      <h:p>Here comes the text</h:p>
    </h:div>
  </xsl:template>
</xsl:transform>