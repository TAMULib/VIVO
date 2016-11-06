<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- orcid_id on individual profile page -->

<#assign orcid_id = propertyGroups.pullProperty("${core}orcidId")!> 

<#if orcid_id?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
    <#list orcid_id.statements as statement>
		 <ul id="individual-orcidid_id" role="list">
			<li role="listitem">
				<span itemprop="orcidid_id">ORCiD</span>
			</li>
			<li role="listitem">
				<span itemprop="orcidid_id"><a class='orcid_link' href='${statement.value}'>${statement.value?replace("http://orcid.org/", "")}</a></span>
			</li>
		</ul>
    </#list>
</#if>