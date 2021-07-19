<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output omit-xml-declaration="yes" method="text" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="no" encoding="UTF-8"
                media-type="application/json; charset=utf-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="*">
        <xsl:text>"</xsl:text>
        <xsl:call-template name="replace">
            <xsl:with-param name="text" select="."/>
        </xsl:call-template>
        <xsl:text>"</xsl:text>
        <xsl:if test="position()!=last()">
            <xsl:text>;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="replace">
        <xsl:param name="text"/>
        <xsl:param name="searchString">"</xsl:param>
        <xsl:param name="replaceString">\"</xsl:param>
        <xsl:choose>
            <xsl:when test="contains($text,$searchString)">
                <xsl:value-of select="substring-before($text,$searchString)"/>
                <xsl:value-of select="$replaceString"/>
            <!--  recursive call -->
                <xsl:call-template name="replace">
                    <xsl:with-param name="text" select="substring-after($text,$searchString)"/>
                    <xsl:with-param name="searchString" select="$searchString"/>
                    <xsl:with-param name="replaceString" select="$replaceString"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/icestats">
        {
        <xsl:for-each select="source">
            "<xsl:value-of select="@mount"/>":
            {
            "name" : "<xsl:value-of select="server_name"/>",
            "listeners" : "<xsl:value-of select="listeners"/>",
            "listener_peak" : "<xsl:value-of select="listener_peak"/>",
            "description" : "<xsl:value-of select="server_description"/>",
            "title" : "<xsl:call-template name="replace"><xsl:with-param name="text" select="title" /></xsl:call-template>",
            "genre" : "<xsl:value-of select="genre"/>",
            "url" : "<xsl:value-of select="server_url"/>"
            }
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
        }
    </xsl:template>
</xsl:stylesheet>