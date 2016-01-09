"""
Name: Anirudh K M
Running top hat in Mac via command prompt
"""

import os

def process(folder):
    """
    """

    files = os.listdir(folder)
    for each in files:
        if folder == "/Volumes/HD1/otau/RNAseq/IT/":
            if not each.startswith('IT_AD4'):
                continue
        if 'r2.fastq' in each.lower():
            continue

        output_file_folder = '{}_I519'.format(each)
        input_file = folder + each
        cmd = ("~/bin/tophat-2.0.14.OSX_x86_64/tophat2 -o {} "
               "--transcriptome-index=/Volumes/HD3v2/ed/otau_i5kmaps/Onthophagus"
               "_Tophat_Index/transcriptome-index -p 8 --b2-very-sensitive "
               "--read-edit-dist 2 /Volumes/HD3v2/ed/otau_i5kmaps/"
               "Onthophagus_Tophat_Index/Otaur.scaffolds {}").format(output_file_folder,
                                                                    input_file)
        os.system(cmd)



if __name__ == '__main__':
    NC = '/Volumes/HD1/otau/RNAseq/NC/'
    IT = '/Volumes/HD1/otau/RNAseq/IT/'
    WA = '/Volumes/HD1/otau/RNAseq/WA/'

    process(NC)
    process(WA)
    process(IT)
