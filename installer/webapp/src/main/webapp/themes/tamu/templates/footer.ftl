<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

</div> <!-- #wrapper-content -->

<footer role="contentinfo">
    <p class="copyright">
        <#if copyright??>
            <small>&copy;${copyright.year?c}
            <#if copyright.url??>
                <a href="${copyright.url}" title="${i18n().menu_copyright}">${copyright.text}</a>
            <#else>
                ${copyright.text}
            </#if>
             | <a class="terms" href="//scholars.library.tamu.edu/terms_scholars/" title="${i18n().menu_termuse}">${i18n().menu_termuse}</a></small> | 
        </#if>
        ${i18n().menu_powered} <a class="powered-by-vivo" href="https://duraspace.org/vivo/" target="_blank" title="${i18n().menu_powered} VIVO"><strong>VIVO</strong></a>
        <#if user.hasRevisionInfoAccess>
             | ${i18n().menu_version} <a href="${version.moreInfoUrl}" title="${i18n().menu_version}">${version.label}</a>
        </#if>
    </p>
    
    <nav role="navigation">
        <ul id="footer-nav" role="list">
 <!--           <li role="listitem"><a href="${urls.about}" title="${i18n().menu_about}">${i18n().menu_about}</a></li> -->
 
 <li role="listitem"><a href="https://scholars.library.tamu.edu/contact_scholars/" title="${i18n().menu_contactus}">${i18n().menu_contactus}</a></li>
 
 <!--           
	<#if urls.contact??>
		<li role="listitem"><a href="${urls.contact}" title="${i18n().menu_contactus}">${i18n().menu_contactus}</a></li>
	</#if> 
-->
<!--            <li role="listitem"><a href="http://www.vivoweb.org/support" target="blank" title="${i18n().menu_support}">${i18n().menu_support}</a></li> -->
			<#if user.loggedIn>
				<#if user.hasSiteAdminAccess>
					<li role="listitem">${i18n().you_can} <a href="${urls.siteAdmin}" title="${i18n().add_content_manage_site}">${i18n().add_content_manage_site}</a> ${i18n().from_site_admin_page}</li>
				</#if>
			<#else>
				<li role="listitem"><a href="${urls.login}" title="Login for Site Admin">Login for Site Admin</a></li>
			</#if>
		</ul>
    </nav>
</footer>

<#include "scripts.ftl">
