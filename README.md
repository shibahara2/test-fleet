# Image Pruner DaemonSet
## 概要
ノード上に蓄積された未使用のコンテナイメージがディスク容量を圧迫することで、podが予期せず終了することがある
([Node-pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/))。
このDaemonsetは各ノード上でpodを起動する。podが定期的に未使用のコンテナイメージを削除することで、ディスクの逼迫を防ぐ。

## 動作
```
while true; do
    ./crictl --config crictl.yaml rmi --prune
    ./crictl --config crictl.yaml images
    sleep 600
done
```
`600`秒に一度以下の処理を実行する。
- `./crictl --config crictl.yaml rmi --prune`: 使用していないイメージを削除
- `./crictl --config crictl.yaml images`: 現在持っているイメージの一覧を表示

## デプロイ方法
- RancherのCD機能を利用する
    - `daemonset.yaml`を開発リポジトリに含める
    - 本リポジトリを新たにGit Reposに登録する
- ノード上で直接`kubectl apply -f daemonset.yaml`を実行する
