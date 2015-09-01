# on view specs
View specs are good for verifying page-elements and structure.  However if we're doing page_objects as well we might as well use those rather than duplicating the effort. 
After all we put most of the structure into the page-object.  If we had a way to specify what elements are always there (default in site-prism is ALL) we could easily make 90% of our view
spec a simple verification of the page object `@page.all_there?`.  This of course doesn't cover logic in the view but that's trivial with the page-object too.
