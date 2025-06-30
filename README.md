# Image Pruner DaemonSet
## 概要
ノード上に蓄積された未使用のコンテナイメージがディスク容量を圧迫することで、podが予期せず終了することがある
([Node-pressure Eviction](https://kubernetes.io/docs/concepts/scheduling-eviction/node-pressure-eviction/))。
このDaemonsetは各ノード上でpodを起動する。podが定期的に未使用のコンテナイメージを削除することで、ディスクの逼迫を防ぐ。

## 目的
ノード上に蓄積された未使用のコンテナイメージは、ディスク容量を圧迫します。この DaemonSet は、定期的にそれらを削除することで、ディスク使用量を管理します。

## 動作概要

- `/usr/local/bin/k3s` を `/crictl` としてシンボリックリンク。
- `crictl.yaml` を作成し、containerd のソケットを指定。
- 10分ごとに以下を実行：
  - `crictl rmi --prune` による未使用イメージの削除
  - `crictl images` による現在のイメージ一覧表示
## 📁 マウントされるボリューム

| 名前       | パス                          | 用途                     |
|------------|-------------------------------|--------------------------|
| `socket`   | `/run/k3s/containerd`         | containerd ソケットへのアクセス |
| `host-k3s` | `/usr/local/bin/k3s`          | `crictl` バイナリとして使用 |


## デプロイ方法

