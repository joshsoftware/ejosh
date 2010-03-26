#eJOSH

eJOSH is a **custom CMS**. eJOSH is **ruby on rails** application that comes with a list of pre-defined layouts and color themes and it is ready to use to build your website or to use for your intranet with it's available plugins (**employee management, Leave management, Timesheet management, etc..**) and it has built in user management (with 3 different roles).

It has built in dynamic sitemap generation for **SEO** compliance.
**Capistrano** default configuration is included that can be modified to fit your needs.

##Steps to deploy and build sites
####1. Clone the project
	git clone git://github.com/joshsoftware/ejosh.git
####2. Install submodules
	git submodule init
	git submodule update
####3. Modify config/deploy.rb as per your need 
####4. Deploy using cap deploy:cold (capistrano will deploy along with the submodules)
####5. Invoke the url http://<hostname>:<portno>/admin
####6. default user/password is admin/joshsoftware
####7. Configure the site by selecting "Site Configuration" menu
####8. Select layout and color from "Customize Layout"
####9. Go to "Content Management" to define content for the site
    - Page Sections are like partials that can reused in any categories or pages.
    - You can define tags to appear as tag clouds
    - You define a category which can appear as sub-menus in a page
    - You define page with meta tag keywords and add categories and/or page section to page
####10. Go to "Navigation Management"
    - You can define what do be shown on header navigation bar and associate each item to a page.
    - You similarly do it for footer 
    - Some of the layout have a provision for quick link you can define those as well.
    - You add the crawler codes that should be part of all of you pages (like google urchin) for SEO
####11. Open config/sitemap.yml and modify as per you requirment
####12. run rake sitemap:generate, it will create sitemap.xml and submit to google, yahoo and bing
####13. It has in-build dynamic sitemap generation.
####14. Click "Go Live" from "Site Configuration"
####15. You site is up and running with SEO compliance
####16. User management, manage different type users
####17. You can select "Plugin" and add or remove the plugins. There are various plugins available to manage day-to-day employee managment, leave managment, etc.

##Contact

Contact **support@joshsoftware.com** for any queries and issues
Report bugs on [lighthoust](http://joshsoftware.lighthouseapp.com/projects/44901-ejosh/tickets)

