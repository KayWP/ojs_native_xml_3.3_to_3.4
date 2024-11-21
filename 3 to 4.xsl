<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://pkp.sfu.ca"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                version="1.0"
                exclude-result-prefixes="xsi">
  <xsl:output method="xml" indent="yes" encoding="UTF-8" />

  <!-- Identity template to copy all elements by default -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- Rename issue_identification to include additional child elements -->
  <xsl:template match="issue_identification">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <!-- Add new elements for 3.4 -->
      <xsl:if test="not(volume)">
        <volume>Unknown</volume>
      </xsl:if>
      <xsl:if test="not(year)">
        <year>
          <xsl:value-of select="substring(date_published, 1, 4)" />
        </year>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Ensure proper transformation of article elements -->
  <xsl:template match="articles/article">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <!-- Add locale attribute -->
      <xsl:if test="not(@locale)">
        <xsl:attribute name="locale">en</xsl:attribute>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Update article publication elements -->
  <xsl:template match="publication">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <!-- Update missing attributes or elements for 3.4 -->
      <xsl:if test="not(@date_published)">
        <date_published>
          <xsl:value-of select="../date_published" />
        </date_published>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Rename sections and ensure proper attributes -->
  <xsl:template match="sections/section">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:if test="not(@abstracts_not_required)">
        <xsl:attribute name="abstracts_not_required">0</xsl:attribute>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <!-- Ensure date_notified exists in issue -->
  <xsl:template match="issue">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:if test="not(date_notified)">
        <date_notified>
          <xsl:value-of select="date_published" />
        </date_notified>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
