	var cartWrapper = $('.cd-cart-container');
	//product id - you don't need a counter in your real project but you can use your real product id
	var productId = 0;

	if( cartWrapper.length > 0 ) {
		//store jQuery objects
		var cartBody = cartWrapper.find('.body')
		var cartList = cartBody.find('ul').eq(0);
		var cartTotal = cartWrapper.find('.checkout').find('span');
		var cartTrigger = cartWrapper.children('.cd-cart-trigger');
		var cartCount = cartTrigger.children('.count')
		var addToCartBtn = $('.cd-add-to-cart');
		var undo = cartWrapper.find('.undo');
		var undoTimeoutId;

		//add product to cart
		addToCartBtn.on('click', function(event){
			event.preventDefault();
			//addToCart($(this));
		});

		//open/close cart
		cartTrigger.on('click', function(event){
			event.preventDefault();
			toggleCart();
		});

		//close cart when clicking on the .cd-cart-container::before (bg layer)
		cartWrapper.on('click', function(event){
			if( $(event.target).is($(this)) ) toggleCart(true);
		});

		//delete an item from the cart
		cartList.on('click', '.delete-item', function(event){
			// event.preventDefault();
			// removeProduct($(event.target).parents('.product'));
		});

		//update item quantity
		cartList.on('change', 'input', function(event){
			quickUpdateCart();
		});

		//reinsert item deleted from the cart
		undo.on('click', 'a', function(event){
			clearInterval(undoTimeoutId);
			event.preventDefault();
			cartList.find('.deleted').addClass('undo-deleted').one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(){
				$(this).off('webkitAnimationEnd oanimationend msAnimationEnd animationend').removeClass('deleted undo-deleted').removeAttr('style');
				quickUpdateCart();
			});
			undo.removeClass('visible');
		});
	}

	function toggleCart(bool) {
		var cartIsOpen = ( typeof bool === 'undefined' ) ? cartWrapper.hasClass('cart-open') : bool;

		if( cartIsOpen ) {
			cartWrapper.removeClass('cart-open');
			// $("body, html").removeClass('hide_scroll');
			//reset undo
			clearInterval(undoTimeoutId);
			undo.removeClass('visible');
			cartList.find('.deleted').remove();

			setTimeout(function(){
				cartBody.scrollTop(0);
				//check if cart empty to hide it
				if( Number(cartCount.find('li').eq(0).text()) == 0) cartWrapper.addClass('empty');
			}, 500);
		} else {
			cartWrapper.addClass('cart-open');
			// $("body, html").addClass('hide_scroll');
		}
	}

	function addToCart(trigger) {
		var cartIsEmpty = cartWrapper.hasClass('empty');
		//update cart product list
		addProduct(trigger);
		//update number of items
		updateCartCount(cartIsEmpty);
		//update total price
		if(trigger)
			updateCartTotal(trigger.data('price'), true);
		else
			updateCartTotal(0, true);
		//show cart
		cartWrapper.removeClass('empty');
	}

	function addProduct(e) {

		var product_name 	= e.data('name');
		var product_price = e.data('price');
		var product_id    = e.data('id');
		var product_image = e.data('image');

		var cart_change_content =  '<div class="input-group" style="width: 100px">' +
                                  '<span class="input-group-btn">' +
                                      '<button type="button" class="btn btn-default btn-quantity btn-circle" data-id="' + product_id +'" data-type="minus" data-field="quantity">' +
                                      	'<span class="glyphicon glyphicon-minus"></span>' +
                                      '</button>' +
                                   '</span>' +
                                   '<input type="text" name="quantity" id="item_quantity_' + product_id + '" class="form-control input-number item_cart_quantity" value="1" min="1" max="10" readonly style="text-align: center">' +
                                   '<span class="input-group-btn">' +
                                   		'<button type="button" class="btn btn-default btn-quantity btn-circle" data-id="' + product_id +'" data-type="plus" data-field="quantity">' +
                                      	'<span class="glyphicon glyphicon-plus"></span>' +
                                      '</button>' +
                                    '</span>' +
                                '</div>';

		var productAdded = $('<li class="product"><div class="product-image"><a href="#0"><img src="'+ product_image +'" alt="placeholder"></a></div><div class="product-details"><h3><a href="#0">' + product_name + '</a></h3><span class="price">Rs. '+ product_price +'</span><div class="actions">' +
				'<div class="quantity">'+ cart_change_content +'</div><a href="#0" class="delete-item">Delete</a></div></div></li>');
		cartList.prepend(productAdded);
	}

	function removeProduct(product) {
		clearInterval(undoTimeoutId);
		cartList.find('.deleted').remove();

		var topPosition = product.offset().top - cartBody.children('ul').offset().top ,
			productQuantity = Number(product.find('.quantity').find('input').val()),
			productTotPrice = Number(product.find('.price').text().replace('Rs.', '')) * productQuantity;

		product.css('top', topPosition+'px').addClass('deleted');

		//update items count + total price
		updateCartTotal(productTotPrice, false);
		updateCartCount(true, -productQuantity);
		undo.addClass('visible');

		//wait 8sec before completely remove the item
		undoTimeoutId = setTimeout(function(){
			undo.removeClass('visible');
			cartList.find('.deleted').remove();
		}, 8000);
	}

	function quickUpdateCart() {
		var quantity = 0;
		var price = 0;

		cartList.children('li:not(.deleted)').each(function(){
			var singleQuantity = Number($(this).find('input').val());
			quantity = quantity + singleQuantity;
			price = price + singleQuantity*Number($(this).find('.price').text().replace('Rs.', ''));
		});

		cartTotal.text(price.toFixed(2));
		cartCount.find('li').eq(0).text(quantity);
		cartCount.find('li').eq(1).text(quantity+1);
	}

	function updateCartCount(emptyCart, quantity) {
		if( typeof quantity === 'undefined' ) {
			var actual = Number(cartCount.find('li').eq(0).text()) + 1;
			var next = actual + 1;

			localStorage.setItem('cart_count', next);

			if( emptyCart ) {
				cartCount.find('li').eq(0).text(actual);
				cartCount.find('li').eq(1).text(next);
			} else {
				cartCount.addClass('update-count');

				setTimeout(function() {
					cartCount.find('li').eq(0).text(actual);

				}, 150);

				setTimeout(function() {
					cartCount.removeClass('update-count');
				}, 200);

				setTimeout(function() {
					cartCount.find('li').eq(1).text(next);
				}, 230);
			}
		} else {
			var actual = Number(cartCount.find('li').eq(0).text()) + quantity;
			var next = actual + 1;

			cartCount.find('li').eq(0).text(actual);
			cartCount.find('li').eq(1).text(next);
			localStorage.setItem('cart_count', next);

		}
	}

	function updateCartTotal(price, bool) {
		bool ? cartTotal.text( (Number(cartTotal.text()) + Number(price)).toFixed(2) )  : cartTotal.text( (Number(cartTotal.text()) - Number(price)).toFixed(2) );
	}

	// $(".cd-cart-container").on('click', '.btn-quantity', function(){
	// 	var id = $(this).data('id')
  //   var type = $(this).data('type');
	// 	var current_quantity = Number($("#item_quantity_" + id).val());
	// 	if(type == "minus" && current_quantity == 1) {
	// 		return removeProduct($(this).parents('.product'))
	// 	}
  //   if(type == "minus" && current_quantity > 1) {
  //     current_quantity -= 1;
  //   }
  //   if(type == "plus") {
  //     current_quantity += 1;
  //   }
  //   $("#item_quantity_" + id).val(current_quantity)
	// 	quickUpdateCart();
  // });

	$(".add-btn").click(function(e){
		var href = $(this).attr('href');
		if(href && href.length > 4) {
		}
		else {
			e.preventDefault()
		}
		//addToCart($(this))
	})

$("#checkout_btn").click(function(){
	var is_logged_in = window.localStorage.getItem('user_session_id')
	if(!is_logged_in) {
		toggleCart();
		return $("#loginModal").modal('show');
	}
	else {
		window.location.href="/cart";
	}
})

// $(".delivery_mode_picker").click(function(){
// 	var mode = $(this).data('mode');
// 	$("#delivery_mode_value").val(mode);
// 	$(".payment_mode_container").removeClass('selected');
// 	$(this).parent('.payment_mode_container').addClass('selected');
// 	var show_slot = $(this).data('show-slot');
// 	if(show_slot == true) {
// 		$("#delivery_slots").removeClass('hide')
// 	}
// 	else {
// 		$("#delivery_slots").addClass('hide')
// 	}
// });
