<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<div style="margin:0px;">

			<div style="position:absolute;top:0px;left:270px;text-align:center;width:210px;border:1px solid #d8d8d8">
				<img src="images/sub_refer_01.gif" /> 업무참조타입
				<img src="images/sub_refer_02.gif" /> 데이터연결타입 
			</div>

			<!-- 최상위 node -->
			<ul style="clear:both;padding-bottom:18px;">
				<li id="link_main" class="bold" style="float:left;margin-bottom:2px;padding:0px 6px 0px 6px;background-color:#d6e6f2">
					<span class="txbgray">
						<xsl:element name="a">
							<xsl:attribute name="href">
								javascript:PageUtil.changeTask('main');
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="packageRels/packageRel/pkgName"/>
							</xsl:attribute>
							<xsl:value-of select="packageRels/packageRel/pkgName"/>
						</xsl:element>
					</span>
				</li>
				
				<xsl:variable name="next" select="packageRels/packageRel/packageRels/packageRel/pkgName"></xsl:variable>
				<xsl:if test="$next != ''">
					<xsl:call-template name="do-recursion">
						<xsl:with-param name="children" select="packageRels/packageRel/packageRels"/>
						<xsl:with-param name="depth" select="1"/>
					</xsl:call-template>
				</xsl:if>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template name="do-recursion">
		<xsl:param name="children"/>
		<xsl:param name="depth"/>
		
		<xsl:variable name="margin-left" select="$depth * 22"></xsl:variable>
		
			<xsl:for-each select="$children/packageRel">
				<xsl:element name="li">
					<xsl:attribute name="style">
						clear:both;
						margin-left:<xsl:value-of select="$margin-left"/>px;
						padding:0px 6px 0px 6px;
						height:19px;
						_margin-bottom:-2px;
					</xsl:attribute>
					<xsl:attribute name="id">link_<xsl:value-of select="./@pkgImgId"/></xsl:attribute>
					<xsl:attribute name="class">normal</xsl:attribute>
										
					<div style="float:left;">
						<xsl:choose>
							<xsl:when test="./@relationType = 'reference'">
								<img src="images/sub_refer_01.gif" aligin="top"/>
							</xsl:when>
							<xsl:otherwise>
								<img src="images/sub_refer_02.gif" aligin="top"/>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<div style="float:left;padding:3px 0px 0px 2px;_margin-top:-4px;">
						<input type="checkbox" checked="checked" disabled="disabled" style="margin:0px;"/>
					</div>				
					<div style="float:left;padding:3px 0px 0px 2px;">				
						<xsl:element name="a">
							<xsl:attribute name="href">
								javascript:PageUtil.changeTask('<xsl:value-of select="./@pkgImgId"/>');
							</xsl:attribute>
							<xsl:attribute name="title">
								<xsl:value-of select="./pkgName"/>
							</xsl:attribute>
							<xsl:value-of select="./pkgName"/>
						</xsl:element>
					</div>
				</xsl:element>
				
				<xsl:variable name="next" select="./packageRels/packageRel/pkgName"></xsl:variable>
				<xsl:if test="$next != ''">
					<xsl:call-template name="do-recursion">
						<xsl:with-param name="children" select="./packageRels"/>
						<xsl:with-param name="depth" select="$depth + 1"/>
					</xsl:call-template>
				</xsl:if>
				
			</xsl:for-each>

	</xsl:template>
	
	<xsl:template name="do-depth">
		<xsl:param name="by"/>
		
		<xsl:choose>
			<xsl:when test="$by &gt; 1">
				<xsl:call-template name="do-depth">
					<xsl:with-param name="by" select="$by * 10"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

