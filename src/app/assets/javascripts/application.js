// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//弹出编辑文本框
function edit_brand(elem){
    $.ajax('/admin/brands/show_edit',{
        method: 'post',
        data: {
            "id": elem
        },
        success: function(transport){
            $('#brand_' + elem).html(transport);
            $('#brand_name_' + elem).focus();
        }
    });
}
//取消编辑
function cancel_edit(elem){
    $.ajax('/admin/brands/cancel_edit',{
        method: 'post',
        data: {
            "id": elem
        },
        success: function(transport){
            $('#brand_' + elem).html(transport);
            $('#message').html("");
            $("#errorExplanation").remove();
        }
    });
}
//编辑保存
function edit(elem){
    $.ajax('/admin/brands/edit',{
        method: 'post',
        data: {
            "id": elem,
            "name": $("#brand_name_" + elem).val()
        },
        success: function(transport){
            if(transport.indexOf("errorExplanation") != -1){
                $('#message').html("");
                if($("#errorExplanation").length > 0){
                    $("#errorExplanation").replaceWith(transport);
                }
                else{
                    $(".pgTitle").eq(0).before(transport);
                }
                window.scrollTo(0,0);
            }
            else{
                $("#errorExplanation").remove();
                $('#brand_' + elem).html(transport);
                $('#message').html("<div class='notice'><p>更新成功。</p></div>");
                window.scrollTo(0,0);
            }

        }
    });
}
