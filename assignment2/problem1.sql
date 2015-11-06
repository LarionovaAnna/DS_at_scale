--select Count(*) from frequency where docid='10398_txt_earn';
--select Count(term) from frequency where docid='10398_txt_earn' and count=1;
--select count(*) from (select term from frequency where docid='10398_txt_earn' and count=1 union select term from frequency where docid='925_txt_trade' and count=1);
--select count(*) from (select count(*) from frequency where (term='law' or term = 'legal')   group by docid);
select count(*) from (select docid, count(term) as term_count from frequency group by docid having count(term)>300);
--select count(*) from (select docid from frequency where term='transaction' intersect select docid from frequency where term ='world');
--SELECT SUM(a.value*b.value) FROM a, b WHERE a.col_num = b.row_num and a.row_num=2 and b.col_num=3 GROUP BY a.row_num, b.col_num;
--select  SUM(a.count*b.count) from frequency a, frequency b where  a.term=b.term and a.docid='10080_txt_crude' and b.docid='17035_txt_earn';
--select  SUM(a.count*b.count) from frequency a, (SELECT * FROM frequency UNION SELECT 'q' as docid, 'washington' as term, 1 as count UNION SELECT 'q' as docid, 'taxes' as term, 1 as count UNION  SELECT 'q' as docid, 'treasury' as term, 1 as count) b where  a.term=b.term and a.docid<b.docid and b.docid='q' group by a.docid order by 1 desc limit 1;
