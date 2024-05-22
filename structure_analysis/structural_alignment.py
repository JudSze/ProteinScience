import sys

from pymol import cmd
import tmalign

if __name__ == "__main__":
    target = sys.argv[1]
    mobile = sys.argv[2]

    cmd.load(target)
    cmd.load(mobile)

    objects = cmd.get_names('objects')
    print(objects)
    aln_results = tmalign.tmalign(objects[0], objects[1], exe="TMscore")