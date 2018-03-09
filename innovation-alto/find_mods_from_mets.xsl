<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:mts="http://www.loc.gov/METS/"
	       version="2.0">

  <xsl:param name="lable">Bibliographic meta-data of the printed version</xsl:param>
  <xsl:output encoding="UTF-8"
	      indent="yes"
	      method="xml"/>
  
  <xsl:template match="/">
    <xsl:for-each select="//mts:mdWrap[@LABEL=$lable]">
      <xsl:copy-of select="mts:xmlData/*"/>
    </xsl:for-each>
  </xsl:template>

</xsl:transform>