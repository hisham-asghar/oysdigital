function UpdateProductPricePreview() {
    var preview = $("#product_price_preview");
    if (preview.length <= 0) return;
    var price = 0.0;
    var form = $("#product_customization_form");
    if (form.length != 1) return;
    form.find("[variant-id]").each(function () {
        //var controltype = $(this).attr("variant-type");
        var variantPrice = $(this).attr("variant-price");
        if (variantPrice == undefined || variantPrice == null || isNaN(variantPrice)) {

        } else {
            try {
                variantPrice = parseFloat(variantPrice);
                price += variantPrice;
            } catch (ex) {

            }
        }
    });
    preview.text("PKR " + price);
}
$(document).ready(function () {

    $(".increment_cart_item").each(function () {
        $(this).click(function () {
            var itemId = $(this).attr("item-Id");
            UpdateCartItemQuantity(itemId, +1);
        });
    });
    function UpdateCartItemQuantity(itemId, add) {
        var inputItem = $(".item_cart_quantity[item-Id=" + itemId + "]");
        var value = inputItem.val();
        if (isNaN(value)) return false;
        value = parseInt(value);
        value += parseInt(add);
        inputItem.attr("data-val", value);
        var action = "/updatecartproductquantity/" + itemId + "/" + value;
        showNotification(null);
        $.post(action, null, function (data) {
            window.setTimeout(function () {
                window.n_overlay.update({
                    icon: "img/check.png",
                    text: data.message
                });

                if (data.success) {
                    var inputItem = $(".item_cart_quantity[item-Id=" + itemId + "]");
                    inputItem.val(inputItem.attr("data-val"));
                }
            }, 1e3);


            window.setTimeout(function () {
                window.n_overlay.hide();
            }, 2e3);
            if (data.cartCount != undefined && data.cartCount != null && !isNaN(data.cartCount)) {
                $(".cart_count").text(data.cartCount);
            }
            console.log(data);
        });
    }
    $(".decrement_cart_item").each(function () {
        $(this).click(function () {
            var itemId = $(this).attr("item-Id");
            var inputItem = $(".item_cart_quantity[item-Id=" + itemId + "]");
            var value = inputItem.val();
            if (isNaN(value)) return false;
            value = parseInt(value);
            if (value <= 1) {
                DeleteItemFromCartConfirm(itemId);
            } else {
                UpdateCartItemQuantity(itemId, -1);
            }
            return false;
            
        });
    });
    $(".delete_cart_item").each(function (e) {
        $(this).click(function () {
            var itemId = $(this).attr("item-Id");
            if (!(itemId == undefined || itemId == null || itemId == "")) {
                DeleteItemFromCartConfirm(itemId);
            }
            return false;
        });
    });

    function DeleteItemFromCartConfirm(itemId) {
        swal.fire({
            title: 'Do you want to remove this ?',
            html: "<p>You won't be able to revert this!</p><input id='swal_decrement_cart_item_id' type='hidden' value='" + itemId + "' class='swal2-input' />",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',

        }).then((result) => {
            if (result.value) {
                var value = $("#swal_decrement_cart_item_id").val();
                DeleteItemFromCart(value);
            }
        })
    }
    function DeleteItemFromCart(itemId) {
        showNotification(null);
        var action = "/deleteproductfromcart/" + itemId;
        $.post(action, null, function (data) {
            if (data.success) {
                $(".delete_cart_item[item-Id=" + data.itemId + "]").closest("tr.product-row").remove();
            }
            window.setTimeout(function () {
                window.n_overlay.update({
                    icon: "img/check.png",
                    text: data.message
                });
            }, 1e3);
            window.setTimeout(function () {
                window.n_overlay.hide();
            }, 2e3);
            if (data.cartCount != undefined && data.cartCount != null && !isNaN(data.cartCount)) {
                $(".cart_count").text(data.cartCount);
            }
            console.log(data);
        });
    }

    var form = $("#product_customization_form");
    if (form.length == 1) {
        form.find("[variant-id]").each(function () {
            var controltype = $(this).attr("variant-type");
            if (controltype == "dropdown") {
                $(this).find("[attr-val-id]").each(function () {
                    $(this).click(function () {
                        debugger;
                        var parent = $(this).closest("[variant-id]");
                        var control = $("#product_attribute_" + parent.attr("variant-id"));
                        control.val($(this).attr("attr-val-id"));
                        var preview = parent.find(".variant_preview");
                        preview.find(".variant_name").text($(this).find(".variant_name").text());
                        preview.find(".variant_price").text($(this).find(".variant_price").text());
                        parent.attr("variant-price", $(this).find(".variant_price").attr("price"));
                        UpdateProductPricePreview();
                    });
                })
            }
            else if (controltype == "datepicker") {
                var variantId = $(this).attr("variant-id");
                var datepickerId = "#product_attribute_" + variantId + "_datepicker";
                $(datepickerId).datepicker({
                    "startDate": new Date()
                });
                $(datepickerId).on('changeDate', function () {
                    var baseInternalId = "#" + $(this).attr("id").replace("datepicker", "");
                    var dayId = baseInternalId + "day";
                    var monthId = baseInternalId + "month";
                    var yearId = baseInternalId + "year";
                    var date = new Date($(this).datepicker('getFormattedDate'));
                    $(dayId).val(date.getDate());
                    $(monthId).val(date.getMonth());
                    $(yearId).val(date.getFullYear());
                    debugger;
                });
            }
        });
        $(".add-to-cart-button").click(function () {
            showNotification(null);
            var formData = form.serialize();
            var cartId = form.attr("cart");
            var productId = form.attr("product_id");
            var action = form.attr("action") + "/" + productId + "/" + cartId;
            $.post(action, formData, function (data) {
                

                window.setTimeout(function () {
                    window.n_overlay.update({
                        icon: "img/check.png",
                        text: "Success"
                    });
                }, 1e3);
                window.setTimeout(function () {
                    window.n_overlay.hide();
                }, 2e3);
                if (data.cartCount != undefined && data.cartCount != null && !isNaN(data.cartCount)) {
                    $(".cart_count").text(data.cartCount);
                }
                console.log(data);

            });
        })
    }

    function showNotification(opts) {
        if (opts == undefined || opts == null) {
            opts = {
                lines: 13, // The number of lines to draw
                length: 11, // The length of each line
                width: 5, // The line thickness
                radius: 17, // The radius of the inner circle
                corners: 1, // Corner roundness (0..1)
                rotate: 0, // The rotation offset
                color: '#FFF', // #rgb or #rrggbb
                speed: 1, // Rounds per second
                trail: 60, // Afterglow percentage
                shadow: false, // Whether to render a shadow
                hwaccel: false, // Whether to use hardware acceleration
                className: 'spinner', // The CSS class to assign to the spinner
                zIndex: 2e9, // The z-index (defaults to 2000000000)
                top: 'auto', // Top position relative to parent in px
                left: 'auto' // Left position relative to parent in px
            };
        }
        var target = document.createElement("div");
        document.body.appendChild(target);
        var spinner = new Spinner(opts).spin(target);
        var overlay = iosOverlay({
            text: "Loading",
            spinner: spinner
        });
        window.n_overlay = overlay;
        
        return false;
    }
});