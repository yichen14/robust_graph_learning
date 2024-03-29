# Robust Graph Learning  
This repository contains source code for the Robust Graph Learning project.

## TODO:

* Add ranking metrics, and test all baselines (static, dynamic, cont) [Recall@k, NDCG@k];
* Test reddit/wiki results, to resolve OOM issues;
* Tables reporting optimal hyperparameters for each datasets.

## Task:
Our code base support:
- Dynamic Link Prediction on Temporal Graph: given several time-steps of a graph dataset, our models could predict the edges change in the future time-steps. 
- Link Prediction on static graph data: given one graph, predict link changes on next graph. 

## Data:

- DBLP
- Enron10
- Facebook
- [Wikipedia](http://snap.stanford.edu/jodie/wikipedia.csv)
- [Reddit](http://snap.stanford.edu/jodie/reddit.csv)

## Attack:
We use [DeepRobust](https://github.com/DSE-MSU/DeepRobust) to perform most of the attacks.  
[DeepRobust Documentation](https://deeprobust.readthedocs.io/en/latest/)  
Attack methods integrated in our framework:  
- [Random Attack](https://deeprobust.readthedocs.io/en/latest/source/deeprobust.graph.global_attack.html#module-deeprobust.graph.global_attack.random_attack)
- [Meta Attack](https://deeprobust.readthedocs.io/en/latest/source/deeprobust.graph.global_attack.html#module-deeprobust.graph.global_attack.mettack)
- [Dice Attack](https://deeprobust.readthedocs.io/en/latest/source/deeprobust.graph.global_attack.html#module-deeprobust.graph.global_attack.dice)
- [Node Attack](https://deeprobust.readthedocs.io/en/latest/graph/node_embedding.html?highlight=node%20attack#node-embedding-attack)
- Temporal Attack (our own method): this method could only apply on temporal dataset. 

## Baseline:

#### Static GNNs:

- [GAE](https://github.com/DaehanKim/vgae_pytorch)
- [VGAE](https://github.com/DaehanKim/vgae_pytorch)

#### Discrete Dynamics GNNs:

- [EvolveGCN (EGCN-H, EGCN-O)](https://github.com/IBM/EvolveGCN)
- [Euler](https://github.com/iHeartGraph/Euler)
- [DySAT](https://github.com/FeiGSSS/DySAT_pytorch)

#### Continuous Dynamics GNN:

- [TGAT](https://github.com/StatsDLMathsRecomSys/Inductive-representation-learning-on-temporal-graphs)

#### Static Defense GNN:

- [Pro-GNN](https://github.com/ChandlerBang/Pro-GNN)

## Config Hyperparameter Setting:

The following table shows the hyperparameter setting for each baseline models in our default configs. 
**Note:** we perform early stop in our infrastructure pipeline.

|        |                     max_epochs                     |               learning rate              |                                  Others                                  |
|:------:|:--------------------------------------------------:|:----------------------------------------:|:------------------------------------------------------------------------:|
|   GAE  |                        1500                        |  enron10: 0.0001; dblp: 0.0001; fb: 0.01 |                                                                          |
|  VGAE  |                        1500                        |  enron10: 0.0001; dblp: 0.0001; fb: 0.01 |     same config file as GAE but change 'encoder' to 'VGCN'                                                                     |
| EGCN-H |                        1500; For wiki, reddit: 800 |  enron10: 0.0001; dblp: 0.005; fb: 0.005 |                                                                          |
| EGCN-O |                        1500; For wiki, reddit: 800 |  enron10: 0.001; dblp: 0.001; fb: 0.001  |                                                                          |
|  EULER |                        1500                        |    enron10: 0.02; dblp: 0.02; fb: 0.02   |                                                                          |
|  DySAT |  For enron10, dblp, fb: 100; For wiki, reddit: 50  | enron10: 0.001; dblp: 0.0005; fb: 0.0005 | For enron10, dblp, fb: walk_len=20; For wiki, reddit: walk_len=5, runs=5 |
|  TGAT  |                         50                         | enron10: 0.0001; dblp: 0.0001; fb: 0.001 |                                                                          |

## Usage:

* Using config file to train: `python3 entries/train.py --cfg ./configs/link_pred_temporal_dblp.yaml`
* Overwrite config by args: `python3 entries/train.py --help`
```bash
train.py [-h] [--gpu GPU] [--device DEVICE] [--seed SEED] [--data_name [DATA_NAME]] [--data_dir [DATA_DIR]]     [--model_name MODEL_NAME]
                [--test_time_step TEST_TIME_STEP] [--input_feat INPUT_FEAT] [--batch_size BATCH_SIZE] [--emb_dim EMB_DIM] [--lr LR]
                [--max_epoch MAX_EPOCH] [--ptb_rate PTB_RATE] [--attack_method ATTACK_METHOD] [--stopping_steps STOPPING_STEPS]
                [--log_interval LOG_INTERVAL] [--evaluate_epoch EVALUATE_EPOCH] [--runs RUNS] [--cfg CFG] [--load LOAD] [--opts ...]
robust graph learning on dynamic graphs

optional arguments:
  -h, --help            show this help message and exit
  --gpu GPU             default is to use gpu
  --device DEVICE       device id
  --seed SEED           Random seed.
  --data_name [DATA_NAME]
                        Choose a dataset from {dblp, enron10, fb}
  --data_dir [DATA_DIR]
                        Input data path.
  --model_name MODEL_NAME
                        Model name
  --test_time_step TEST_TIME_STEP
                        number of test time steps
  --input_feat INPUT_FEAT
                        0: No pretrain, 1: Pretrain with the learned embeddings, 2: Pretrain with BERT.
  --batch_size BATCH_SIZE
                        recommendation batch size.
  --emb_dim EMB_DIM     node embedding size.
  --lr LR               Learning rate.
  --max_epoch MAX_EPOCH
                        Number of epoch.
  --ptb_rate PTB_RATE   attack rate.
  --attack_method ATTACK_METHOD
                        attack_func.
  --stopping_steps STOPPING_STEPS
                        Number of epoch for early stopping
  --log_interval LOG_INTERVAL
                        Iter interval of printing loss.
  --evaluate_epoch EVALUATE_EPOCH
                        Epoch interval of evaluation.
  --runs RUNS           Independent runs with different seeds.
  --cfg CFG             specify particular yaml configuration to use
  --load LOAD           specify saved checkpoint to evaluate
  --opts ...            Command line options to overwrite configs
```

