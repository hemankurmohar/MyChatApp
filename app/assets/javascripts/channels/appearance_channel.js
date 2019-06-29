$(function() {
        App.cable.subscriptions.create(
            {
                channel: "AppearanceChannel",
                user_id: 1
            },
            {
                received: function(data) {


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
        );
});