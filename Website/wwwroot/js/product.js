$(function(){

  $(".single-product-quantity .btn-number").click(function(){
    var current_quantity = Number($("#item_quantity").val());
    var type = $(this).data('type');
    if(type == "minus" && current_quantity > 1) {
      current_quantity -= 1;
    }
    if(type == "plus") {
      current_quantity += 1;
    }
    $("#item_quantity").val(current_quantity)
  });

});
