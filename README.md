# 回転ずし（Rotating_Sushi）
ミニチュア回転づしを作るプロジェクトです．  
The system of rotating sushi
![sr](https://user-images.githubusercontent.com/44542331/222964563-e4a0a451-9ff0-4c1a-9cfe-6fa57a71ffef.png)

  
# 何なの？（What's this like?）
回転づしの模型を作れば，いつでも回転づしな気分を楽しめます．  
回転づし成分が足りない時に廻してください．ペロペロー．  
  
This is a project to make a system of miniature rotating sushi what's like sushi parlor in Japan.  
Main parts are made by 3Dprinter.  
And some parts are easily buy on web stores and 100yen shops.  
This system is designed carefully for anyone to be able to make it on a low budget.  

# 3Dモデル(3D models)
システムで利用する部品群は，なるべく入手性の良い購入品（売っているもの）を採用していますが，一部の部品は独自形状なので，自作する必要があります．  
それらは3Dプリンタで作る想定で設計してあります．  
3DプリントするためのSTLファイルもこのリポジトリで公開しています．  
3Dプリンタを持っていない人は，DMM.makeやJLCPCB（コスパいい）といったプリントサービスを利用してもよいでしょう．  

This repository contains 3D models(STL file) of parts to make yourself by using 3Dprinter.  
If you don't have 3Dprinter, you can also use 3Dprinting service on a Internet, like DMM.make and JLCPCB(cost effective).  

## マテリアル
筆者はPLAで出力しています．プリントサービスを使う場合はナイロンでも良いと思います．  

# 工具
## プーラー（プーリー抜き）
モータとして秋月電子通商で販売されているステッピングモータ（NEMA17相当）を使っています．  
特に安いためこのモータを選定しました．  
同等のモータはAliexpressなどでも販売されています．それらはNEMA17で検索するとよいでしょう．  
秋月モータを使う場合ですが，このモータには最初からプーリーがはめ込まれた状態で販売されています．今回の用途ではプーリーを取り外す必要があります．  
取り外すために必要な工具を次に示します．  
例えばこれが使えます（https://www.amazon.co.jp/%E3%83%AB%E3%83%9C%E3%83%8A%E3%83%AA%E3%82%A8-%E3%82%AF%E3%83%A9%E3%83%B3%E3%82%AF%E3%83%97%E3%83%BC%E3%83%AA%E3%83%BC-%E3%83%99%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0%E3%83%97%E3%83%BC%E3%83%A9%E3%83%BC-%E3%83%99%E3%82%A2%E3%83%AA%E3%83%B3%E3%82%B0-%E3%83%97%E3%83%BC%E3%83%AA%E3%83%BC%E5%A4%96%E3%81%97/dp/B0855ZZHYZ/ref=sr_1_11_sspa?keywords=%E3%82%AE%E3%82%A2%E3%83%97%E3%83%BC%E3%83%A9%E3%83%BC&qid=1684989354&sr=8-11-spons&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyTUJOUE5MWDdNUzRBJmVuY3J5cHRlZElkPUEwMDQyNjAxMjZDME5VRVNDTTZKNCZlbmNyeXB0ZWRBZElkPUEzUk5JQ043S0sxUVc5JndpZGdldE5hbWU9c3BfbXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ&th=1）  

![1678196227728](https://user-images.githubusercontent.com/44542331/224652613-f2dbdd30-c6ee-4f61-9e63-5c027d782dce.jpg)
![1678196227734](https://user-images.githubusercontent.com/44542331/224652711-58f4a818-7763-46cc-a327-0150c9a4f63f.jpg)

## 電動ドリル
ベースとなるボードに穴をあけるために，電動ドリルを使います．筆者はBoschが好きです．  
合わせてφ8㎜とφ10mm，φ12mmくらいのドリルが必要だった気がします．木工用で良いと思います．  

## ドライバーとか
ドライバーとかスパナが必要です．使うネジとナットのサイズに合わせてそろえてください．筆者はTOPのコンビ・ラチェット（トップ工業）が好きです．  
### L型6角レンチ・セット
ホームセンターで売ってる7本組くらいの安いやつでOKです．筆者はPBかANEX（兼古製作所）が好きです．  

# BOM

|型式（品番）|購入先|価格[¥]|使用個数|使用部位|その他|
---|---|---|---|---|---
|STB8-65|MonotaRO|75|1|スプロケットシャフト||
|M10x45|MonotaRO|429|1|アイドラシャフト|M10x45キャップボルト（半ねじ）2本入り|
|628ZZ|MonotaRO|169|1|スプロケットベアリング|ミニチュアベアリング（内径φ8）|
|6000|MonotaRO|249|2|アイドラベアリング|内径φ10|
|AS103-16-15|MonotaRO|289|2|アイドラシャフトスペーサー|アルミスペーサー|
|3.1x20|MonotaRO|299|1||首下20mm木ねじ|
|W6-20TB5-60TB8-380mm|Aliexpress(ZhuFeng fittings Store)|599（送料込み）|1|ドライブプーリー＆ドリブンプーリー|ドライブベルト付き|
|18x18|Aliexpress(Hardware appliances)|1749（送料込み）|1|ベルトコンベア|連結可能|
|17PM-K044-AKZ|秋月電子通商|700|1|モータ|バイポーラステッピングモータP-06578（NEMA17相当）　付属のプーリーを外す必要がある|
|A4988|amazon(Akozon)|651（送料込み）|1|モータドライバ|Aliexpressにもある|
||||1|マイコンボードorFPGAボード|お好みで|
||||1|12v-24v程度の電源|1Aもあれば十分|
||ダイソー|330|1|ベースボード|600x300 木製パンチ板|
|自作|-|-|2|アイドラプーリー| roller_web.stl |
|自作|-|-|1|ドライブスプロケット| drive_roller_web.stl |
|自作|-|-|1|ドライブシャフトベアリングホルダ| bearing_holder_web.stl |
||ダイソー|110| * |おもしろ消しゴムシリーズ|寿司|

  
ベアリングは開放でもZZ（カバー付き）でもお好きなものをどうぞ．  

## マイコン or FPGA
ステッピング・モータのドライバはA4988です．このドライバ・ボードに対して指令を送るために，マイコン・ボードかFPGAボードが別途必要です．  
その用途には，ArduinoとかESP32でいいんじゃないでしょうか？筆者はTang Nano 9Kか，Tang Primer 20Kでやっているので，sampleフォルダにこれらのFPGAboard用のプロジェクト一式が入っています．そのうちRX62N（ルネサス）も使うかもしれません．  
SampleとしてM5StickCのArduinoスケッチも用意しました．  

## システム構成
システムを構成する大まかな要素を図示します．  
基礎的なシステム  
![sr](https://github.com/Lathe-Mariel/Rotating_Sushi/blob/main/references/photos/basic_system.png)
  
筆者のシステム  
![sr](https://github.com/Lathe-Mariel/Rotating_Sushi/blob/main/references/photos/mysystem.png)
