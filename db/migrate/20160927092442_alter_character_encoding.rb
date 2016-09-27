class AlterCharacterEncoding < ActiveRecord::Migration
  def change
    alter table hoges modify column name varchar(80) character set utf8bm4 collate utf8mb4_bin not null;

    4. データベースの文字コードを修正する
    alter database <DBNAME> character set utf8mb4;
    5. 既存のrow_formatデータを修正する
    alter table <TABLENAME> ROW_FORMAT=DYNAMIC;
    6. 既存のテーブルの文字コードをutf8mb4に修正する
    alter table <TABLENAME> convert to character set utf8mb4;
  end
end
