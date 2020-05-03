using Generics.DataModels;
using Microsoft.AspNetCore.Html;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Razor.TagHelpers;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.OpenApi.Extensions;
using System;
using System.Collections.Generic;
using System.Text;

namespace Generics.WebHelper.Extensions
{
    public enum HtmlInputType
    {
        Text = 1,
        Number = 2,
        Hidden = 3,
        Checbox = 4,
        TextArea = 5,
        DropdownList = 6,
        File = 7,
        Select=8,

    };
    public enum HtmlButtonType
    {

         SUBMIT = 1,
         BUTTON = 2
    };

    public static class CHtmlHelper
    {


        public static string ParseInputField(HtmlInputType htmlInputType)
        {
            return htmlInputType switch
            {
                HtmlInputType.Text => "text",
                HtmlInputType.Number => "number",
                HtmlInputType.Hidden => "hidden",
                HtmlInputType.Checbox => "checkbox",
                HtmlInputType.File => "file",
                HtmlInputType.Select => "select",
                _ => "",
            };
        }
        public static string ParseButtonTypes(HtmlButtonType htmlButtonType)
        {
            switch (htmlButtonType)
            {
                case HtmlButtonType.BUTTON:
                    return "button";
                case HtmlButtonType.SUBMIT:
                    return "submit";
            }
            return "";
        }


     
        const string TrueStatus = "<div class='icon-container text-center'><span class='ti-check text-info font-bold'></span></div>";
        const string FalseStatus = "<div class='icon-container text-center'><span class='ti-close text-danger font-bold'></span></div>";


        public static IHtmlContent GetSeoCard(string seName, string metaTitle, string metaKeywords, string metaDescription)
        {
            var html = "";
            html += (GetCardHeader(12, "Seo"));
            html += HtmlInputType.Text.GenerateInputField("Search engine friendly page name", seName, "seName");
            html += HtmlInputType.Text.GenerateInputField("Meta Title", metaTitle, "MetaTitle");
            html += HtmlInputType.Text.GenerateInputField("Meta Keywords", metaKeywords, "MetaKeywords");
            html += HtmlInputType.Text.GenerateInputField("Meta Description", metaDescription, "MetaDescription");
            return new HtmlString(html);
        }

        public static IHtmlContent GenerateButton(string name,HtmlButtonType htmlButtonType)
        {
            var str = $"<button class='btn btn-raised btn-primary waves-effect' type='{ParseButtonTypes(htmlButtonType)}'>{name}</button>";
            return new HtmlString(str);
        }
        public static IHtmlContent GenerateDataTime(string name,string value,string mappingName)
        {
            var str = $"<div class='form-group form-float'><label>{name}</label><div class='input-group'><div class='input-group-prepend'><span class='input-group-text'><i class='zmdi zmdi-time'></i></span></div><input type='text' class='form-control timepicker' name='{mappingName}' value='{value}' placeholder='Please choose a time...'></div></div>";
            return new HtmlString(str);
        }
        public static IHtmlContent GenerateHeader(string heading,string link,string linkText)
        {
            var str = $"<div class='block-header'> " +
                $"<div class='row'> " +
                $"<div class='col-lg-7 col-md-6 col-sm- 12'> " +
                $"<h2>{heading}</h2> " +
                $"<ul class='breadcrumb'> " +
                $"<li class='breadcrumb-item'>" +
                $"<a href='{link}'><i class='fa fa-arrow-left'></i> {linkText}</a></li>" +
                $"</ul> " +
                $"<button class='btn btn-primary btn-icon mobile_menu' type='button'>" +
                $"<i class='zmdi zmdi-sort-amount-desc'></i>" +
                $"</button> </div></div></div>";

            return new HtmlString(str);
        }
        public static IHtmlContent CheckTag(this bool status)
            => new HtmlString(status ? TrueStatus : FalseStatus);
        
        public static IHtmlContent GenerateTableHeader(params string[] items)
        {
            var tr = Tr(items);
            var str = "<div class='table-responsive'> <table class='table m-b-0'>" +
                $"<thead class='thead-light'> {tr} </thead>";
            return new HtmlString(str);
        }

        public static IHtmlContent GenerateTableFooter()
        {
            return new HtmlString("</table>");
        }

        public static IHtmlContent Tr(params string[] items)
        {
            var tds = "";
            if (items != null && items.Length > 0)
            {
                var type = "";
                for (var i = 0; i < items.Length; i++)
                {
                    if (i == 0) type = items[i];
                    else tds += $"<{type}>{items[i]}</{type}>";
                }
            }
            var tr = $"<tr>{tds}</tr>";
            return new HtmlString(tr);
        }
        
        public static IHtmlContent TableHead(params string[] items)
        {
            var start = ("<thead>");
            var end = ("</thead>");
            return new HtmlString(start + Tr(items) + end);
        }
        public static IHtmlContent Dl(Dictionary<string,object> dic)
        {
            var dls = "";
            if (dic != null && dic.Count > 0)
            {
                foreach(var item in dic)
                {
                    if (item.Value.ToString()!="" && item.Value.ToString() != "0")
                    dls += $"<dt>{item.Key}</dt>" + $"<dd>{item.Value}</dd>";
                   
                }
            }
            var dl = $"<dl>{dls}</dl>";
            return new HtmlString(dl);
        }
        public static IHtmlContent TableFoot(params string[] items)
        {
            var start = ("<tfoot>");
            var end = ("</tfoot>");
            return new HtmlString(start + Tr(items) + end);
        }

        public static IHtmlContent GetCardHeader(int col,string heading)
        {
            var card = $"<div class='row clearfix'> <div class='col-lg-{col} col-md-{col} col-sm-{col}'> <div class='card'>" +
                $" <div class='header'> <h2><strong> {heading} </strong></h2> </div><div class='body'>";
            return  new  HtmlString(card);
        }
        public static IHtmlContent GetCardFooter()
        {
            return new HtmlString("</div></div></div></div>");
        }
        public static IHtmlContent GenerateDropdownField(this List<KeyValuePair<string, string>> pairs, string displayName, string value, string mappingName, string id = "", bool isRequired = true)
        {
            if (pairs == null || pairs.Count == 0) return new HtmlString("");

            var required = isRequired ? "required" : "";
            var options = "";
            foreach(var pair in pairs)
            {
                var selected = pair.Key == value ? "selected=''" : "";
                options += $"<option {selected} value='{pair.Key}'>{pair.Value}</option>";
            }
            var select = $"<div class='form-group form-float'> " +
                $"<label>{displayName}</label> " +
                $"<select class='form-control show-tick' {required} name='{mappingName}'>" +
                $"{options}</select></div>";

            return new HtmlString(select);
        }

        public static IHtmlContent GenerateInputField(this HtmlInputType htmlInputType, string displayName, string value, string mappingName, string id = "", bool isRequired = true)
        {
            var htmlInputTypeValue = ParseInputField(htmlInputType);
            var required = isRequired ? "required" : "";

            string str;
            if (htmlInputType == HtmlInputType.TextArea)
            {
                str = $"<div class='form-group form-float'><label>{displayName}</label>" +
                    $"<textarea id='{id}' class='form-control' " +
                              $"placeholder='{displayName}' name='{mappingName}' {required}>{value} </textarea>" +
                              $"</div>";
            }
            else if (htmlInputType == HtmlInputType.Checbox)
            {
                str = $"<div class='form-group'> <div class='checkbox'> <input id='{id}' {(value == "True" ? "checked=''" : "")} type='{htmlInputTypeValue}' name='{mappingName}' {value}> " +
                    $"<label for='{id}' name='{mappingName}'>{displayName}</label></div></div>";
            }else
            {
                str = $"<div class='form-group form-float'><label>{displayName}</label><input type='{htmlInputTypeValue}' class='form-control' " +
                              $"value='{value}' placeholder='{displayName}' name='{mappingName}' {required}>" +
                              $"</div>";
            }


            return new HtmlString(str);
        }
        public static IHtmlContent GenerateInputField(string displayName, string value,HtmlInputType htmlInputType,string mappingName, string id = "",bool isRequired = true)
        {
            return htmlInputType.GenerateInputField(displayName, value, mappingName, id, isRequired);
        }
        
        public static IHtmlContent GenerateSingleSelectField(string displayName,string mappingName,Dictionary<int,string>options,int selectedValId = 0, bool includeEmpty = false)
        {
            var str = $"<div class='form-group form-float'> <label>{displayName}</label> <select class='form-control show-tick' name='{mappingName}'>" +
            (includeEmpty ? $" <option value ='0' selected>None</option>" : "");
            if (options != null)
            {
                foreach(var keyvalues in options)
                {
                    var selectedStr = keyvalues.Key == selectedValId ? "selected" : "";
                    str += $"<option value='{keyvalues.Key}' {selectedStr} > {keyvalues.Value}  </option>";
                }

            }
            str += "</select> </div>";

            return new HtmlString(str);
        }
        public static IHtmlContent GenerateSingleSelectFieldString(string displayName, string mappingName, Dictionary<string, string> options, string selectedValId = null, bool includeEmpty = false)
        {
            var str = $"<div class='form-group form-float'> <label>{displayName}</label> <select class='form-control  show-tick' name='{mappingName}'>" +
            (includeEmpty ? $" <option value ='0' selected>None</option>" : "");
            if (options != null)
            {
                foreach (var keyvalues in options)
                {
                    var selectedStr = keyvalues.Key == selectedValId ? "selected" : "";
                    str += $"<option value='{keyvalues.Key}' {selectedStr} > {keyvalues.Value}  </option>";
                }

            }
            str += "</select> </div>";

            return new HtmlString(str);
        }



    }

    public static class ButtonHelper
    {
        const string buttonTemplate = @"<a href='{1}' class='btn {2}'><i class='zmdi {3}'></i>&nbsp;{0}</a>";

        public static IHtmlContent Edit(string link)
            => new HtmlString(string.Format(buttonTemplate, "Edit", link, "btn-default", "zmdi-edit"));
        public static IHtmlContent Delete(string link)
            => new HtmlString(string.Format(buttonTemplate, "Delete", link, "btn-danger", "zmdi-delete"));


        public static IHtmlContent Create(string link)
        => new HtmlString(string.Format(buttonTemplate, "Create", link, "btn btn-success float-right", "zmdi-plus"));

        public static IHtmlContent EditSmall(string link)
            => new HtmlString(string.Format(buttonTemplate, "Edit", link, "btn-sm btn-default", "zmdi-edit"));
        public static IHtmlContent DeleteSmall(string link)
            => new HtmlString(string.Format(buttonTemplate, "Delete", link, "btn-sm btn-danger", "zmdi-delete"));
        public static IHtmlContent DetailSmall(string link)
            => new HtmlString(string.Format(buttonTemplate, "Detail", link, "btn-sm btn-info", "zmdi-info-outline"));
        public static IHtmlContent CreateSmall(string link,string text)
                   => new HtmlString(string.Format(buttonTemplate, text, link, "btn-sm btn-primary", "zmdi-plus"));
        public static IHtmlContent BackToListSmall(string link)
                   => new HtmlString(string.Format(buttonTemplate,"Back to list", link, "btn-sm btn-info", ""));

    }
}
