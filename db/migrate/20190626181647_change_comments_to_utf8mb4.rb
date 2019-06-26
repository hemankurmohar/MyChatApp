class ChangeCommentsToUtf8mb4 < ActiveRecord::Migration[5.2]
    def up
      execute "ALTER TABLE messages CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
      execute "ALTER TABLE messages MODIFY message TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    end
    def down
      execute "ALTER TABLE comments CONVERT TO CHARACTER SET utf8 COLLATE utf8_bin"
      execute "ALTER TABLE comments MODIFY name VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_bin"
      execute "ALTER TABLE comments MODIFY body TEXT CHARACTER SET utf8 COLLATE utf8_bin"
    end
end
