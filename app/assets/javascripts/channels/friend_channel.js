$(function() {
    $('[data-channel-subscribe="friend"]').each(function(index, element) {
        var $element = $(element),
            friend_id = $element.data('friend-id')
        messageTemplate = $('[data-role="message-template"]');
        imageTemplate =  $('[data-role="image-template"]');
        $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

        App.cable.subscriptions.create(
            {
                channel: "FriendChannel",
                friend: friend_id
            },
            {
                received: function(data) {
                    if(data.is_attachment){
                        if($('#myModal').hasClass('show')){
                            $('#myModal').modal('toggle');
                        }
                        var content = imageTemplate.children().clone(true, true);

                        if(data.attachment_content_type.includes("image")==false){
                             content.find('[data-role="other"]').attr("href",data.file_name.url);
                            content.find('[data-role="image"]').remove();
                         }else{
                             content.find('[data-role="image"]').attr("src",data.file_name.url);
                            content.find('[data-role="other"]').remove();
                         }
                        $element.append(content);
                        $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
                    }else{
                        var current_user = $('#current_user').val();
                        var content = messageTemplate.children().clone(true, true);
                        content.find('[data-role="message-text"]').text(data.message);
                        var date = new Date(data.created_at);
                        content.find('[data-role="message-date"]').text(date.format("dd mmm HH:MM"));
                        if(data.user_id==current_user){
                            content.find('[data-role="message-content"]').attr("class","message-content1");
                        }
                        $element.append(content);
                        $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
                    }

                }
            }
        );
    });
});