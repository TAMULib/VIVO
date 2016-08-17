<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Overview on individual profile page -->

<#if altmetricEnabled??>
<#assign identifier = individual.uri!>
	<#if identifier?has_content> <#-- true when the property is in the list, even if not populated (when editing) -->
		<div id="plumx_tamu" style="float: right;">
			<a href="https://plu.mx/tamu/a/?repo_url=http://vivo.library.tamu.edu/display/${identifier[identifier?last_index_of("/")+1..]}" class="plumx-plum-print-popup" data-popup="left" data-hide-when-empty="true" data-site="tamu" data-badge="true"></a>			
		</div>
	</#if>
</#if>





