<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:fn="http://www.w3.org/2005/xpath-functions"
		exclude-result-prefixes="h fn xs"
		version="2">

  <xsl:output method="xml"
	      encoding="UTF-8"
	      indent="yes"/>

  <xsl:variable name="styles">
    <xsl:copy-of select="/alto/Styles"/>
  </xsl:variable>

  <xsl:template match="/alto">
    <h:div>
      <xsl:apply-templates select="Layout"/>
    </h:div>
  </xsl:template>

  <xsl:template match="Layout">
    <h:div>
      <xsl:apply-templates select="Page"/>
    </h:div>
  </xsl:template>

  <xsl:template match="Page">
    <h:div>
      <xsl:call-template name="make_id"/>
      <xsl:apply-templates select="PrintSpace"/>
    </h:div>
  </xsl:template>

  <xsl:template match="PrintSpace">
    <h:div>
      <xsl:call-template name="make_id"/>
      <xsl:apply-templates select="TextBlock"/>
    </h:div>
  </xsl:template>

  <xsl:template match="TextBlock">
    <h:p>
      <xsl:call-template name="make_id"/>
      <xsl:attribute name="style"><xsl:call-template name="make_style"/>width: <xsl:value-of select="@WIDTH"/>px;</xsl:attribute>
      <xsl:apply-templates select="TextLine"/>
    </h:p>
  </xsl:template>

  <xsl:template match="TextLine">
   <h:span>
     <xsl:variable name="width" as="xs:integer" select="@WIDTH"/>
     <xsl:variable name="parwid" as="xs:integer" select="parent::TextBlock/@WIDTH"/>
      <xsl:call-template name="make_id"/>
      <xsl:variable name="style">
	<xsl:call-template name="make_style"/>
      </xsl:variable>
      <xsl:attribute name="style">
	<xsl:choose><xsl:when test="string-length($style)"><xsl:value-of select="$style"/></xsl:when>
	<xsl:otherwise>text-align: inherit;width: <xsl:value-of select="100 * $width div $parwid"/>%;</xsl:otherwise></xsl:choose>
      </xsl:attribute>
    <xsl:apply-templates select="String|SP"/>
   </h:span><h:br/>
  </xsl:template>

  <xsl:template match="SP"><xsl:text>
</xsl:text></xsl:template>

  <xsl:template match="String">
    <h:span>
      <xsl:call-template name="make_id"/>
      <xsl:variable name="style">
	<xsl:call-template name="make_style"/>
      </xsl:variable>
      <xsl:if test="string-length($style)"><xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute></xsl:if> 
      <xsl:apply-templates select="@CONTENT"/>
    </h:span>
  </xsl:template>

  <xsl:template name="make_id">
    <xsl:if test="@ID">
      <xsl:attribute name="id"><xsl:value-of select="@ID"/></xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="make_style">
    <xsl:for-each select="fn:tokenize(@STYLEREFS,'\s+')">
      <xsl:variable name="ref"><xsl:value-of select="normalize-space(.)"/></xsl:variable>
      <xsl:variable name="style" select="$styles//node()[@ID=$ref]"/>
      <xsl:choose>
	<xsl:when test="$style/@ALIGN='Block'">text-align:justify;</xsl:when>
	<xsl:when test="$style/@ALIGN='Left'">text-align:left;</xsl:when>
	<xsl:when test="$style/@ALIGN='Right'">text-align:right;</xsl:when>
	<xsl:when test="$style/@ALIGN='Center'">text-align:center;</xsl:when>
	<xsl:when test="$style/@FONTSTYLE='italics'">font-style:italic;</xsl:when>
	<xsl:when test="$style/@FONTSIZE">font-size:<xsl:value-of select="$style/@FONTSIZE"/>px;</xsl:when>
	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


</xsl:transform>