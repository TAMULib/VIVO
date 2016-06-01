<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Overview on individual profile page -->

<#if altmetricEnabled??>
<#assign doi = propertyGroups.getProperty("http://purl.org/ontology/bibo/doi")!>
	<#if doi?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
		<#if doi.statements[0]??>
			<div id="plumx_tamu">
				<a href="https://plu.mx/tamu/a/?doi=${doi.statements[0].value}" class="plumx-plum-print-popup" data-popup="hidden" data-hide-when-empty="true" data-site="tamu" data-badge="false"></a>
			</div>
		</#if>
	</#if>
</#if>

