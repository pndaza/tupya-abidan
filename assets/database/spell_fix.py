import sqlite3

def spell_fix(text):
    return text.replace("၎င်းင်း", "၎င်း")
db_file = 'tupya.db'

conn = sqlite3.connect(db_file)
cursor = conn.cursor()  

cursor.execute('SELECT * FROM topic')

rows = cursor.fetchall()
for row in rows:
    id = row[0]
    name = spell_fix(row[1])
    detail = spell_fix(row[2])

    cursor.execute('UPDATE topic SET name = ?, detail = ? WHERE id = ?', (name, detail, id))

conn.commit()
conn.close()