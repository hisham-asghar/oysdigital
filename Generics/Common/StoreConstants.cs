using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.Common
{
    public class StoreConstants
    {
        public const int StoreId = 1;

        public static string DefaultStoreTimeZoneId = "";

        public static string CustomerStoreTimeZoneId { get; set; }
        public static int LanguageId = 1;

        public class CartSettings
        {
            public static int MaximumShoppingCartItems = 9999;
            public static int MinimumShoppingCartItems = 1;

            public static bool AllowCartItemEditing { get; set; }
            public static bool DisplayCartAfterAddingProduct { get; set; }
            public static bool MiniShoppingCartEnabled { get; set; }
            public static bool DisplayWishlistAfterAddingProduct { get; set; }
        }
    }
}
