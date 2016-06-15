# defmodule Spaces.Helper.PostSlack do
#   use Spaces.Web, :controller

#   @messages %{tag_post: "A new post of your subscribed posts has just been added to spaces", 
#       user_tag_post: "A new post of your subscribed user has just been added to spaces",
#       comment_post: "You have a new comment on your post"
#     }

#   def postSlack(conn, %{user_id: user_id, message_tag: message_tag}) do
#     message = @messages[messages_tag]
#     if !is_nil(message) do
      
#     else
#       "Invalid message tag given. Kindly send a valid mesaage_tag symbol"
#     end
#   end
# end