<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- VIVO-specific default object property statement template. 
    
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
-->

<#import "lib-meta-tags.ftl" as lmt>

<@showStatement statement />

<#macro showStatement statement>
    <#-- The query retrieves a type only for Persons. Post-processing will remove all but one. --> 
  	<#if statement.subclass??>
		<a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label!statement.localName!}</a>
	<#else>
		<#-- Disable showing thesis for Works by Students DCH -->
		<#if statement.type! == "Thesis">
		
			<#if ( statement.label?index_of(" Master's Thesis.") > 1 ) >
				${statement.label?replace(" Doctoral Dissertation.", "")?keep_before("). ")}). <a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label?replace(" Master's Thesis.", "")?keep_after("). ")!statement.localName!}</a>&nbsp; ${statement.title!}		
				<br />
				<img src="../themes/tamu/images/masters.png" title="Doctoral Dissertation" alt="Doctoral Dissertation">		
				<a href="http://hdl.handle.net/1969.1/${profileUrl(statement.uri("object"))?replace("/vivo/display/n", "")}" title="${i18n().name}"><img src="../themes/tamu/images/openaccess.png" title="Open Access Link" alt="Open Access Link"></a>				
			<#elseif ( statement.label?index_of(" Doctoral Dissertation.") > 1 ) >
				${statement.label?replace(" Doctoral Dissertation.", "")?keep_before("). ")}). <a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label?replace(" Doctoral Dissertation.", "")?keep_after("). ")!statement.localName!}</a>&nbsp; ${statement.title!}
				<br />
				<img src="../themes/tamu/images/doctoral.png" title="Doctoral Dissertation" alt="Doctoral Dissertation">				
				<a href="http://hdl.handle.net/1969.1/${profileUrl(statement.uri("object"))?replace("/vivo/display/n", "")}" title="${i18n().name}"><img src="../themes/tamu/images/openaccess.png" title="Open Access Link" alt="Open Access Link"></a>		
			</#if>	
			
		<#else>
			<a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label!statement.localName!}</a>&nbsp; ${statement.title!statement.type!}
		</#if>		
	</#if>
	<@lmt.addCitationMetaTag uri=(statement.specificObjectType) content=(statement.label!) />
</#macro>