# linux_setting

## 前提条件

### /bin/shはbashにする

確認コマンド。
以下でbashかdashか確認可能。

```$ ls -l /bin/sh
lrwxrwxrwx 1 root root 4 Feb 20  2021 /bin/sh -> dash
```

bashになっていない場合は以下のコマンドを実行する。

```
$ sudo dpkg-reconfigure dash
画面が表示されたらnoを選択する。
```

## 設置階層

以下の階層に設置する

```
/home/user/linux_setting 
```

## セットアップ手順

### *.exampleからファイルを生成

```
make createExample
```

生成されたファイルに環境変数を入力する。

### スクリプトを実行

```
make setup
```

### Vimのプラグインをインストール

```
:PlugInstall
```
