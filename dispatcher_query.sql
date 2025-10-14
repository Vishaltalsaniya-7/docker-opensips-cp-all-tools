
id|setid|destination           |socket                |state|probe_mode|weight|priority|attrs|description       |
--+-----+----------------------+----------------------+-----+----------+------+--------+-----+------------------+
 1|    1|sip:192.168.1.246:5060|udp:192.168.1.246:5070|    0|         1|10    |       0|     |FusionPBX Main    |
 4|    1|sip:192.168.1.247:5060|udp:192.168.1.246:5070|    2|         0|10    |       0|     |FusionPBX Server 2|
 5|    1|sip:192.168.1.248:5060|udp:192.168.1.246:5070|    2|         0|10    |       0|     |FusionPBX Server 3|


id|gwid|type|address               |strip|pri_prefix|attrs            |probe_mode|state|socket|description                 |
--+----+----+----------------------+-----+----------+-----------------+----------+-----+------+----------------------------+
16|1   |   0|sip:192.168.1.246:5060|    0|          |primary          |         2|    0|      |Primary FusionPBX/FreeSWITCH|
17|2   |   0|sip:192.168.1.247:5060|    0|          |                 |         1|    0|      |FusionPBX Backup Server     |
21|101 |   0|sip:192.168.1.246:5060|    0|          |domain=vishal.org|         1|    0|      |FusionPBX for vishal.org    |

ruleid|groupid|prefix|timerec|priority|routeid|gwlist|sort_alg|attrs            |description                             |sort_profile|
------+-------+------+-------+--------+-------+------+--------+-----------------+----------------------------------------+------------+
     1|1      |      |       |       1|       |1,2   |N       |                 |Default route to FusionPBX with failover|           0|
     2|1      |1     |       |       0|       |1     |N       |                 |US numbers to primary                   |           0|
     9|1      |      |       |       0|       |101   |N       |domain=vishal.org|Route vishal.org to FusionPBX           |           0|



DELETE FROM dispatcher;

INSERT INTO dispatcher (
  id, setid, destination, socket, state, probe_mode, weight, priority, attrs, description
) VALUES
  (1, 1, 'sip:192.168.1.246:5060', 'udp:192.168.1.246:5070', 0, 1, '10', 0, '', 'FusionPBX Main'),
  (4, 1, 'sip:192.168.1.247:5060', 'udp:192.168.1.246:5070', 0, 1, '10', 0, '', 'FusionPBX Server 2'),
  (5, 1, 'sip:192.168.1.248:5060', 'udp:192.168.1.246:5070', 0, 1, '10', 0, '', 'FusionPBX Server 3');



