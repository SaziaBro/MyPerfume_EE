<script src="js/ViewOperations/jquery-2.2.3.min.js"></script>
<script src="js/ViewOperations/bootstrap.js"></script>
<script src="js/ViewOperations/move-top.js"></script>
<script src="js/ViewOperations/easing.js"></script>
<script>
    jQuery(document).ready(function($) {
        $(".scroll").click(function(event) {
            event.preventDefault();
            $('html,body').animate({
                scrollTop: $(this.hash).offset().top
            }, 900);
        });
    });
</script>

