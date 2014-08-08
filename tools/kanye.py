import mechanize
from retrying import retry
from BeautifulSoup import BeautifulSoup
from pandas import DataFrame
import numpy as np


# TODO add retry logic and error handling
example_artist_url = 'http://genius.com/artists/Kanye-west'


@retry(wait_exponential_multiplier=1000, wait_exponential_max=10000, stop_max_attempt_number=7)
def get_album_urls(artist_url):
    br = mechanize.Browser()
    br.addheaders = [('User-agent', 'Mozilla/5.0 (Macintosh; U; ' +
        ' Intel Mac OS X 10_6; en-us) ' +
        ' AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9')]
    html = br.open(artist_url).read()
    soup = BeautifulSoup(html)
    albums = soup.find(name='ul', attrs={'class': "album_list primary_list"})
    return ['http://genius.com/' + child.get('href') for child in albums.findChildren('a')]


example_album_url = 'http://genius.com//albums/Kanye-west/808s-heartbreak'


@retry(wait_exponential_multiplier=1000, wait_exponential_max=10000, stop_max_attempt_number=7)
def get_song_urls(album_url):
    br = mechanize.Browser()
    br.addheaders = [('User-agent', 'Mozilla/5.0 (Macintosh; U; ' +
        ' Intel Mac OS X 10_6; en-us) ' +
        ' AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9')]
    html = br.open(album_url).read()
    soup = BeautifulSoup(html)
    # could do this with re but eh
    songs = soup.find(name='ul', attrs={'class': "song_list primary_list  has_track_order"})
    songs = songs or soup.find(name='ul', attrs={'class': "song_list primary_list "})
    return [child.get('href') for child in songs.findChildren('a')]


example_song_url = "http://rap.genius.com/Kanye-west-good-morning-lyrics"

@retry(wait_exponential_multiplier=1000, wait_exponential_max=10000, stop_max_attempt_number=7)
def extract_lyrics(song_url):
    br = mechanize.Browser()
    br.addheaders = [('User-agent', 'Mozilla/5.0 (Macintosh; U; ' +
        ' Intel Mac OS X 10_6; en-us) ' +
        ' AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9')]
    html = br.open(song_url).read()
    soup = BeautifulSoup(html)

    lyrics = soup.find(name='div', attrs={'class': 'lyrics'}).find('p')
    lyrics_text = " ".join([child.getText() for child in lyrics.findChildren()])
    return lyrics_text


def get_all_artist_lyrics(artist_url):
    df = DataFrame(np.empty(0, dtype=[('artist_url', object),
                                      ('album_url', object),
                                      ('song_url', object),
                                      ('lyrics', object)]))
    album_urls = get_album_urls(artist_url)

    print "found album urls " + ", ".join(album_urls)
    row_num = 0
    for album_url in album_urls:
        try:
            song_urls = get_song_urls(album_url)
        except:
            print "failed to get songs for " + album_url
            continue
        finally:
            print "got songs for " + album_url
        for song_url in song_urls:
            try:
                lyrics = extract_lyrics(song_url)
            except:
                print "failed to get lyrics for " + song_url
            finally:
                print "got lyrics for " + song_url
                df.loc[row_num] = [artist_url, album_url, song_url, lyrics]
                row_num += 1

    # todo save line by line
    df.to_pickle(artist_url.split("/")[-1] + '.pkl')
    return df
