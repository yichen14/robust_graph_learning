python3 entries/train.py --cfg ./configs/link_pred_temporal_fb.yaml --ptb_rate 0.1 --lr 0.001 --attack_method random --model_name EGCNO --device 1 &
python3 entries/train.py --cfg ./configs/link_pred_temporal_fb.yaml --ptb_rate 0.3 --lr 0.001 --attack_method random --model_name EGCNO --device 1 &
python3 entries/train.py --cfg ./configs/link_pred_temporal_fb.yaml --ptb_rate 0.5 --lr 0.001 --attack_method random --model_name EGCNO --device 1 &
python3 entries/train.py --cfg ./configs/link_pred_temporal_fb.yaml --ptb_rate 0.7 --lr 0.001 --attack_method random --model_name EGCNO --device 1