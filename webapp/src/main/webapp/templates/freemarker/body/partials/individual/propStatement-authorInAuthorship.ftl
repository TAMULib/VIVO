<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Custom object property statement view for faux property "selected publications". See the PropertyConfig.n3 file for details.
    
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
 
<#import "lib-sequence.ftl" as s>
<#import "lib-datetime.ftl" as dt>

<@showAuthorship statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showAuthorship statement>
<#if statement.hideThis?has_content>
    <span class="hideThis">&nbsp;</span>
    <script type="text/javascript" >
        $('span.hideThis').parent().parent().addClass("hideThis");
        if ( $('h3#relatedBy-Authorship').attr('class').length == 0 ) {
            $('h3#relatedBy-Authorship').addClass('hiddenPubs');
        }
        $('span.hideThis').parent().remove();
    </script>
<#else>

	<#local bookTitleForChapterTAMU>
		<#if statement.bookTitleForChapterTAMU??>
			<#if statement.bookTitleForChapterTAMU?has_content>
				${statement.bookTitleForChapterTAMU}
			</#if>
		<#else>

		</#if>
	</#local>	

	<#local fullEditorListTAMU>
		<#if statement.fullEditorListTAMU??>
			<#if statement.fullEditorListTAMU?has_content>
				${statement.fullEditorListTAMU}
			</#if>
		<#else>

		</#if>
	</#local>		
	
	
    <#local citationDetails>
        <#if statement.subclass??>
            <#if statement.subclass?contains("Article")>
                <#if statement.journal??>
                    <em>${statement.journal!}</em>.&nbsp;
                    <#if statement.volume?? && statement.issue?? && statement.startPage?? && statement.endPage??>
                        <em>${statement.volume!}</em>(${statement.issue!}), ${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.volume?? && statement.issue?? && statement.startPage??>
                        <em>${statement.volume!}</em>(${statement.issue!}), ${statement.startPage!}.
                    <#elseif statement.volume?? && statement.issue??>
                        <em>${statement.volume!}</em>(${statement.issue!}),
					<#elseif statement.volume?? && statement.startPage?? && statement.endPage??>
                       <em>${statement.volume!}</em>, ${statement.startPage!}-${statement.endPage!}.							
                    <#elseif statement.volume?? && statement.startPage??>
                       <em>${statement.volume!}</em>, ${statement.startPage!}.					
					<#elseif statement.volume??>
                        ${statement.volume!}.
                    <#elseif statement.startPage?? && statement.endPage??>
                        ${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.startPage??>
                        ${statement.startPage!}.
                    </#if>
				<#else>
				    <#if statement.volume?? && statement.issue?? && statement.startPage?? && statement.endPage??>
                        <em>${statement.volume!}</em>(${statement.issue!}), ${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.volume?? && statement.issue?? && statement.startPage??>
                        <em>${statement.volume!}</em>(${statement.issue!}), ${statement.startPage!}.
                    <#elseif statement.volume?? && statement.issue??>
                        <em>${statement.volume!}</em>(${statement.issue!}),
					<#elseif statement.volume?? && statement.startPage?? && statement.endPage??>
                       <em>${statement.volume!}</em>, ${statement.startPage!}-${statement.endPage!}.							
                    <#elseif statement.volume?? && statement.startPage??>
                       <em>${statement.volume!}</em>, ${statement.startPage!}.					
					<#elseif statement.volume??>
                        ${statement.volume!}.
                    <#elseif statement.startPage?? && statement.endPage??>
                        ${statement.startPage!}-${statement.endPage!}.
                    <#elseif statement.startPage??>
                        ${statement.startPage!}.
                    </#if>
                </#if>
            <#elseif statement.subclass?contains("Chapter")>
                <#if statement.journal??>
                    <em>${statement.journal!}</em>.
                <#elseif statement.appearsIn??>
                    <em>${statement.appearsIn!}</em>.
                <#elseif statement.partOf??>
                    <em>${statement.partOf!}</em>.
                </#if>
                <#if statement.fullEditorListTAMU??>
                    ${statement.fullEditorListTAMU!}&nbsp;(Eds.),
                </#if>
                <#if statement.bookTitleForChapterTAMU??> 
                    ${statement.bookTitleForChapterTAMU!}.
                </#if>				
                <#if statement.startPage?? && statement.endPage??>
                    (pp. ${statement.startPage!}-${statement.endPage!}).
                <#elseif statement.startPage??>
                    ${statement.startPage!}.
                </#if>
                <#if statement.locale?? && statement.publisher??>
                    ${statement.locale!}:&nbsp;${statement.publisher!}.
                <#elseif statement.locale??>
                    ${statement.locale!}.
                <#elseif statement.publisher??>
                    ${statement.publisher!}.
                </#if>
            <#elseif statement.subclass?contains("Book")>
                <#if statement.volume?? && (statement.volume!?length > 0 )>
                    ${i18n().volume_abbreviated}&nbsp;${statement.volume!}.&nbsp;
                </#if>
                <#if statement.editor??>
                    ${i18n().editor_abbreviated}&nbsp;${statement.editor!}.&nbsp;
                </#if>
                <#if statement.locale?? && statement.publisher??>
                    ${statement.locale!}:&nbsp;${statement.publisher!}.
                <#elseif statement.locale??>
                    ${statement.locale!}.
                <#elseif statement.publisher??>
                    ${statement.publisher!}.
                </#if>
            <#else>
                <#if statement.journal??>
                    <em>${statement.journal!}</em>.
                <#elseif statement.appearsIn??>
                    <em>${statement.appearsIn!}</em>.
                <#elseif statement.partOf??>
                    <em>${statement.partOf!}</em>.
                </#if>
                <#if statement.editor??>
                    ${i18n().editor_abbreviated} ${statement.editor!}.&nbsp;
                </#if>
                <#if statement.startPage?? && statement.endPage??>
                    ${statement.startPage!}-${statement.endPage!}.
                <#elseif statement.startPage??>
                    ${statement.startPage!}.
                </#if>
            </#if>
        </#if>
    </#local>

    <#local resourceTitle>
        <#if statement.infoResource??>
            <#if citationDetails?has_content>
                <a href="${profileUrl(statement.uri("infoResource"))}"  title="${i18n().resource_name}">${statement.infoResourceName?remove_ending(".")}</a>.&nbsp;
            <#else>
                <a href="${profileUrl(statement.uri("infoResource"))}"  title="${i18n().resource_name}">${statement.infoResourceName?remove_ending(".")}</a>
            </#if>
        <#else>
            <#-- This shouldn't happen, but we must provide for it -->
            <a href="${profileUrl(statement.uri("authorship"))}" title="${i18n().missing_info_resource}">${i18n().missing_info_resource}</a>
        </#if>
    </#local>
	
    <#local digitalObjectIdentifier>
        <#if statement.digitalObjectIdentifier??>
		    <#if statement.digitalObjectIdentifier?has_content>
				<a class="full-text-link" href="http://dx.doi.org/${statement.digitalObjectIdentifier}" target="_blank">DOI</a>
			</#if>
        </#if>
    </#local>

	<#local fullAuthorListTAMU>
		<#if statement.fullAuthorListTAMU??>
			<#if statement.fullAuthorListTAMU?has_content>
				${statement.fullAuthorListTAMU}
			</#if>
		<#else>
			
		</#if>
	</#local>

    <#local pubMedID>
        <#if statement.pubMedID??>
		    <#if statement.pubMedID?has_content>
				<a class="pubmed-link" href="https://www.ncbi.nlm.nih.gov/pubmed/${statement.pubMedID}" target="_blank">PubMed</a>
			</#if>
        </#if>
    </#local>	

    <#local altMetric>
        <#if altmetricEnabled??>
            <#if statement.doi??>
                <div data-badge-popover="right" data-badge-type="4" data-doi="${statement.doi}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.pmid??>
                <div data-badge-popover="right" data-badge-type="4" data-pmid="${statement.pmid}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.isbn10??>
                <div data-badge-popover="right" data-badge-type="4" data-isbn="${statement.isbn10}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.isbn13??>
                <div data-badge-popover="right" data-badge-type="4" data-isbn="${statement.isbn13}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            </#if>
        </#if>
    </#local>
	
    <#local dimensions>
        <#if altmetricEnabled??>
            <#if statement.doi??>
				<span class="__dimensions_badge_embed__" data-doi="${statement.doi}" data-hide-zero-citations="true" data-style="small_rectangle" style="display: inline; top: -5px; position: relative;"></span><script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>
			<#elseif statement.pmid??>
				<span class="__dimensions_badge_embed__" data-doi="${statement.pmid}" data-hide-zero-citations="true" data-style="small_rectangle" style="display: inline;"></span><script async src="https://badge.dimensions.ai/badge.js" charset="utf-8"></script>
            </#if>
        </#if>
    </#local>	

	${fullAuthorListTAMU} <@dt.citation_yearSpan "${statement.dateTime!}" /> ${resourceTitle?trim}${citationDetails?trim}

	<div>	
		<img src="../themes/tamu/images/blank.gif"> ${digitalObjectIdentifier} ${pubMedID} ${altMetric}
	</div>	


    <#local altMetric>
        <#if altmetricEnabled??>
            <#if statement.doi??>
                <div data-badge-popover="right" data-badge-type="4" data-doi="${statement.doi}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.pmid??>
                <div data-badge-popover="right" data-badge-type="4" data-pmid="${statement.pmid}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.isbn10??>
                <div data-badge-popover="right" data-badge-type="4" data-isbn="${statement.isbn10}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            <#elseif statement.isbn13??>
                <div data-badge-popover="right" data-badge-type="4" data-isbn="${statement.isbn13}" data-hide-no-mentions="true" class="altmetric-embed" style="display: inline;"></div>
            </#if>
        </#if>
    </#local>

    <#local plum>
        <#if plumPrintEnabled??>
            <#if statement.doi??>
                <#assign plumIdParam = "doi=${statement.doi}">
            <#elseif statement.pmid??>
                <#assign plumIdParam = "pmid=${statement.pmid}">
            <#elseif statement.isbn10??>
                <#assign plumIdParam = "isbn=${statement.isbn10}">
            <#elseif statement.isbn13??>
                <#assign plumIdParam = "isbn=${statement.isbn13}">
            <#elseif statement.oclc??>
                <#assign plumIdParam = "oclc=${statement.oclc}">
            </#if>
            <#if plumIdParam??>
                <div class="plum-print-wrapper" style="display: inline-block; vertical-align: top">
                    <a class="plumx-plum-print-popup"
                       href="https://plu.mx/plum/a/?${plumIdParam}"
                       data-popup="hidden"
                       data-hide-when-empty="${plumPrintHideEmpty}"
                       data-site="plum"
                       data-size="tiny"
                       data-badge="true"></a>
                </div>
            </#if>
        </#if>
    </#local>

    ${resourceTitle} ${citationDetails} <@dt.yearSpan "${statement.dateTime!}" /> ${altMetric} ${plum}
</#if>
</#macro>
