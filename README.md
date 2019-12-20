#Lane-booking の仕様について:
- ユーザー登録ができる
- ユーザー登録が正しければ、予約権を管理者が付与できる
- 管理者はユーザー登録を抹消することができる
- 予約をする
- 予約枠があるだけ入る
- 予約一覧をユーザーも管理者も閲覧できる
- 管理者および予約者は予約内容を更新、削除することができる。

#未導入の機能
- Slot数をauthorityから変数で変更
- Slot設定時刻をauthorityから変数で変更
- 次の作業予定：
  1."begin_time, :end_time, :max_num"のカラムをSlotsに作る。既存のカラムは型が違うのでダメ。stringで再度作成する。orderテーブルにindexをはる。
  2.３つの値が、orders#authorityから設定してSlotsに値を入れれるようにする。
  ３. f.selectからslot_idに値が入っていかない問題を解決する。slot_idの型が問題？slot_idにはどうも値は入る。Controllerからだけ値が入る。。。どうもuser_idにforeign_keyが入っていない。このあたりが問題か？
      とりあえず一度user_idを削除してみた。再度user_idを作成して再度トライする
  4. f.selectで[1..30]とかで値をとって、max_numに代入。slot_id.count<max_numとかでMax値判定
  5.form_withやform_forのselectタグにend_time begin_timeを呼び出せるようにする。参考資料貼っとく
  > http://tech.portalshit.net/2011/12/01/how-to-set-escape-false-on-rails-select-tag/
  > https://qiita.com/colorrabaddbit/items/b58888506e41d1370fd1
  >> form_for @slot do |f|からの
  >> <%= f.select :slot_id, Slot.all.map{|s| [s.begin_time, s.end_time]} %>