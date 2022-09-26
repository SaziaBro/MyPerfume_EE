$(function () { 
    $('.add').on('click',function(){
    
    var $qty=$(this).closest('.input-group').find('.qty');
        var currentVal = parseInt($qty.val());
      //  alert(currentVal)
        if (!isNaN(currentVal)) {
            $qty.val(currentVal + 1);
        }
    });
    $('.minus').on('click',function(){
        var $qty=$(this).closest('.input-group').find('.qty');
        var currentVal = parseInt($qty.val());
        if (!isNaN(currentVal) && currentVal > 0) {
            $qty.val(currentVal - 1);
        }
    });
});