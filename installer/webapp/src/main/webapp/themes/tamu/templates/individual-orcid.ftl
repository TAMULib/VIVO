<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- orcid_id on individual profile page -->

<#assign bio_orcid = "" /> 

<#if orcidInfo??>
    <#list orcidInfo.orcids?keys as key>
		<#assign bio_orcid = key>
    </#list>
	<#if bio_orcid?has_content>	
		<ul id="individual-orcidid_id" role="list">
			<li role="listitem">
				<span itemprop="orcidid_id"><strong>ORCiD</strong></span>
			</li>
			<li role="listitem">
				<span itemprop="orcidid_id"><a class='orcid_link' href='${bio_orcid}'>${bio_orcid?replace("http://orcid.org/", "")}</a></span>
			</li>
		</ul>
	</#if>
</#if>
