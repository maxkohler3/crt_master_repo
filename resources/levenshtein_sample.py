from Levenshtein import levenshtein_distance_weighted

def get_levenshtein_distance(self, incoming_text, master_text):
        return levenshtein_distance_weighted(incoming_text,master_text)