<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- NOTICE: This is SAMPLE Google Analytics code. You must replace it with your institution's code. 
Please see documentation at https://confluence.cornell.edu/display/ennsrd/Google+Analytics+for+UI. -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-54069646-2', 'auto');
  ga('send', 'pageview');
</script>

<script>
$.getJSON('https://php.library.tamu.edu/utilities/vivo_page_info.php', function(data) {
	var client_ip = data['client_ip'];
	var client_referrer = data['referer'];
	var display_title;
	
		if ($(".person").length > 0) {
			display_title = 'person';
		} else { 
			try {
				display_title = $(".display-title")[0].innerHTML;
			} catch(err) {
				display_title = "";
			}
		}
	
	 $.ajax({
	  url: '//scholars.library.tamu.edu/vivo_editor/insert_stat.php',
	  method: 'GET',
	  data: {
		  client_ip: client_ip, 
		  client_referrer: client_referrer,
		  display_title: display_title
	  }
	});
	
});
</script> 