$(function() {
        App.cable.subscriptions.create(
            {
                channel: "AppearanceChannel"
            },
            {
                received: function(data) {
                    id = "";
                    if(data.hasOwnProperty("notification_count")){
                        id ="#notification_"+ data.user_id;
                        $(id).text(data.notification_count);
                    }
                    else{
                        id ="#status_"+ data.id;
                        if(data.status){
                            $(id).text("online");
                            $(id).attr("class"," badge badge-success");

                        }else{
                            $(id).text("offline");
                            $(id).attr("class"," badge badge-light");
                        }
                    }




                }
            }
        );
});