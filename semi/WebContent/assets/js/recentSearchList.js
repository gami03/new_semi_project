var user_no = window.user_no;

$(function() {
    $.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    });

    var recentSearchInner = $('.recent_search_inner');
    recentSearchList();
    
    function recentSearchList() {
        if(user_no != "") {
            $.ajax({
                type: "get",
                url: "user_search_recent_list.do",
                data: {
                    user_no: user_no
                },
                dataType: "json",
                success: function(response) {
                    $.each(response.recentList, function(index, recentItem) {
                        var button = $('<button>').addClass('recent_search_text').text(recentItem.keyword);
                        $('<div>').addClass('recent_search_item').append(button).appendTo(recentSearchInner);
                    });
                },
                error: function() {
                    $('<div>').text('최근 검색어를 불러오는 도중 오류가 발생했습니다.').appendTo(recentSearchInner);
                }
            });
        }
    }
});
