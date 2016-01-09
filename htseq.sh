
for f in *_I519; do samtools sort -@ 8 -m 1G $f/accepted_hits.bam $f/accepted_hits_sorted; samtools index $f/accepted_hits_sorted.bam; done
