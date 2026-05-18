---
name: language-learning-tracker
description: |
  Manages learning journeys for new programming languages/frameworks: folder structure, roadmap, step-by-step daily GUIDE, end-of-day exercises (requirements only, no full solutions), code REVIEW after self-work, session reports, progress SUMMARY, and NEXT lesson suggestions.

  Use when the user:
  - Starts learning a new language/framework (INIT)
  - Asks what to study today or next (NEXT)
  - Wants step-by-step guidance for a roadmap day (GUIDE)
  - Finished the day exercise and wants code review (REVIEW, "chấm bài", "review Day N")
  - Completed a session and wants to log progress (SESSION)
  - Wants a progress recap (SUMMARY)
  - Works in a folder with report/sessions/ or report/agent/ structure

  Trigger from context even without exact keywords.
metadata:
  version: "2.0"
  packaged: "2026-05-18"
---

# Language Learning Tracker

Quản lý hành trình học ngôn ngữ/framework mới. Mỗi buổi học → session file; context agent → tiến độ; GUIDE dạy từng bước; bài cuối ngày user **tự làm**; REVIEW chấm code; SESSION ghi lại.

## Luồng học chuẩn một ngày

```
NEXT (biết học gì) → GUIDE (bước + snippet) → Day exercise (tự làm, yêu cầu-only)
    → REVIEW (chấm code) → SESSION (ghi report) → context_v{n+1} nếu cần
```

---

## Cấu trúc thư mục

```
{Language}/
├── {language}_learning_roadmap.md
├── README.md
├── projects/
│   └── {phase-folder}/{ProjectName}/
└── report/
    ├── agent/                    ← CHỈ TẠO MỚI, không sửa file cũ
    │   └── context_v{n}_{YYYY-MM-DD}.md
    └── sessions/
        ├── session_template.md
        └── session_{YYYY-MM-DD}_phase{N}_day{N}.md
```

**`report/agent/`**: Cập nhật = tạo `context_v{n+1}_{date}.md`, đánh dấu `[[CHANGED]]` tại phần đổi.

---

## Chế độ hoạt động

| Chế độ | Khi nào |
|--------|---------|
| INIT | Bắt đầu học ngôn ngữ/framework mới |
| GUIDE | Hướng dẫn từng bước một Day trong roadmap |
| REVIEW | User đã tự làm bài cuối ngày — chấm code |
| SESSION | Ghi lại buổi học vừa xong |
| SUMMARY | Tổng hợp toàn bộ hành trình |
| NEXT | Gợi ý bài học tiếp theo |

Nếu không rõ intent → hỏi một câu ngắn.

---

## Quy tắc dạy học (GUIDE + NEXT) — BẮT BUỘC

### Lý thuyết / từng bước

- Snippet ngắn (5–15 dòng) minh họa concept.
- Mental model mapping từ ngôn ngữ user đã biết.
- User gõ + chạy từng bước trước khi sang bước tiếp.

### Bài tập cuối ngày — KHÔNG full solution

**Chỉ đưa:** checklist yêu cầu / stretch, bảng dữ liệu mẫu, ví dụ input/output, tiêu chí tự check.

**Không đưa** (trừ khi user **explicitly** yêu cầu đáp án):

- Full file solution, copy-paste block thay thế implement, rewrite full code user trong GUIDE.

**Kẹt:** gợi ý hướng (API, pattern, pseudo) — không dump solution.

**Xong bài:** → REVIEW → pass → SESSION.

---

## INIT — Khởi tạo lộ trình

Hỏi nếu thiếu: ngôn ngữ, background, mục tiêu, domain ví dụ, thời gian/tuần.

**Tạo:**

1. `README.md` — overview, phases, quy tắc folder
2. `{language}_learning_roadmap.md` — profile, strategy, mental model mapping, 8–12 phases (1 topic/phase), common mistakes; **Day exercise = yêu cầu + I/O, không embed full solution**
3. `report/agent/context_v1_{today}.md` — dùng Appendix B; Instruction gồm quy tắc GUIDE/REVIEW
4. `report/sessions/session_template.md` — copy từ Appendix A

Xong → bắt đầu Phase 1 Day 1.

**Tips roadmap:** mental model mapping quan trọng nhất với senior dev; mỗi phase 1 project domain user thích; progression tuyến tính; không over-explain basics.

---

## GUIDE — Hướng dẫn từng bước

1. Đọc context mới nhất + roadmap Day đó
2. Chia bước: setup → concepts
3. Mỗi bước: mục tiêu + snippet + "chạy và quan sát"
4. Kết bằng bài cuối ngày (yêu cầu-only)
5. Nhắc: REVIEW → SESSION

**Format trả lời:**

```markdown
## Chuẩn bị
[Tạo project theo toolchain — dùng Appendix D, điền đường dẫn thực tế, không viết chung chung]

## Bước N — [Concept]
**Mục tiêu:** ...
[Snippet + mapping]
**Thử:** ...
**Ghi nhớ:** ...

## Bài tập cuối ngày — tự làm
### Yêu cầu bắt buộc
- [ ] ...
### Stretch
- [ ] ...
### Dữ liệu / output mong đợi
[Bảng — không full code]
### Tiêu chí tự check
- [ ] ...

## Sau khi xong
REVIEW → SESSION
```

User xin "cho code luôn" → nhắc quy tắc; solution chỉ khi **explicitly** yêu cầu sau khi đã thử.

---

## REVIEW — Chấm bài cuối ngày

1. Context mới nhất
2. Yêu cầu Day trong roadmap
3. Code user (`projects/` hoặc paste)
4. Review — **không** rewrite full file

**Format:**

```markdown
## Kết quả: [Pass / Pass với góp ý / Cần làm lại]

## Đã đạt
- ...

## Cần sửa (cao → thấp)
- [Vấn đề + hướng sửa, không full patch]

## Convention & smell
- [JS/RN smell, naming, struct vs class, ...]

## Stretch
- ...

## Bước tiếp
- Sửa → REVIEW lại HOẶC SESSION nếu pass
- Day tiếp: [topic]
```

**Nguyên tắc:** trích dẫn code user; giải thích qua mapping ngôn ngữ cũ; gợi ý tối đa vài dòng; nêu requirement roadmap còn thiếu. Pass → đề xuất SESSION.

---

## SESSION — Ghi buổi học

1. Context mới nhất
2. User mô tả tự do → suy ra phase/day, thời lượng, concepts, patterns, hiểu rõ vs mơ hồ, exercise
3. Tạo `report/sessions/session_{YYYY-MM-DD}_phase{N}_day{N}.md` (Appendix A)
4. Progress đổi lớn → `context_v{n+1}_{today}.md` (Appendix B, `[[CHANGED]]`)
5. Tóm tắt 2–3 câu + bài tiếp theo; nếu có REVIEW trước → ghi feedback vào session

---

## SUMMARY — Tổng hợp hành trình

Đọc: context mới nhất → tất cả sessions (trừ template) → roadmap.

```markdown
## Tổng quan hành trình học [Language]
- Ngày bắt đầu → nay: X tuần, Y buổi (~Z giờ)
- Tiến độ: Phase N/M — [Tên] (~X%)

## Kiến thức đã nắm (theo phase)
## Điểm mạnh
## Điểm cần củng cố
## Knowledge gaps tiềm ẩn
## Next milestone
```

---

## NEXT — Gợi ý bài tiếp theo

1. Context mới nhất
2. Session gần nhất (nếu có)
3. Roadmap phase hiện tại

```markdown
**Bạn đang ở:** Phase N — [Tên], Day X

**Bài học tiếp theo: [Topic]**
Lý do: [1 câu]

**Cần ôn lại trước:** [Điểm mơ hồ từ buổi trước — bỏ qua nếu không có]

**Learning objectives:**
- ...

**Tạo project — từng bước:**
[Dùng Appendix D để lấy đúng hướng dẫn theo toolchain — điền đường dẫn thực tế]

**Bài tập cuối ngày:** [Checklist yêu cầu — không full code]

**Ước tính:** ~X giờ
```

---

# Appendix A — Session report template

Copy → `report/sessions/session_{YYYY-MM-DD}_phase{N}_day{N}.md`

```markdown
# Session Report — [DATE] — [TOPIC]

## Thông tin buổi học
- **Ngày:** YYYY-MM-DD
- **Phase:** Phase N — [Tên phase]
- **Day:** Day N — [Tên topic]
- **Thời lượng:** ~X giờ

## Mục tiêu buổi học
- [ ] Mục tiêu 1
- [ ] Mục tiêu 2

## Những gì đã học
### Concept chính
### Code đã viết
### Mapping ngôn ngữ cũ → mới
| Cũ | Mới |
|---|---|

## Điểm đã hiểu rõ
## Điểm còn chưa chắc / cần ôn lại

## Exercise / Project đã làm
- [ ] Đã tự làm bài tập cuối ngày (không copy solution)
- [ ] Đã qua REVIEW (Pass / Pass với góp ý)
### Code
### Review feedback (nếu có)

## Ghi chú thêm
## Next session
**Chủ đề tiếp theo:** Day N+1 — [Tên topic]
```

---

# Appendix B — Agent context template

Copy → `report/agent/context_v1_{YYYY-MM-DD}.md` (chỉ tạo mới khi cập nhật: `context_v{n+1}_...`)

```markdown
# Agent Context — v{N} ({YYYY-MM-DD})

> RULE: Chỉ TẠO MỚI. Cập nhật → context_v{n+1}_{date}.md + [[CHANGED]]

## Learner Profile
- **Background:** ...
- **Goal:** ...
- **Domain ưa thích:** ...
- **Trình độ:** ...

## Learning Roadmap ({N} Phases)
| Phase | Tuần | Chủ đề | Project |

## Folder Structure
## Current Progress
- **Ngày bắt đầu:** ...
- **Phase hiện tại:** ...
- **Ngày học hiện tại:** Day N / Chưa bắt đầu
- **Tổng số buổi học:** ...

## Key Mental Model Mappings
## Common Mistakes to Watch For

## Instruction for AI Agent
- Giải thích qua lens ngôn ngữ user đã biết; ví dụ theo domain
- **GUIDE:** snippet OK; bài cuối ngày chỉ yêu cầu + I/O
- **REVIEW:** chấm sau khi user tự làm; không rewrite full file; pass → SESSION
- SESSION → `report/sessions/`; context agent chỉ tạo mới
```

---

# Appendix C — Day exercise block (GUIDE kết thúc)

```markdown
## Bài tập cuối ngày — tự làm

### Yêu cầu bắt buộc
- [ ] ...

### Stretch (tùy chọn)
- [ ] ...

### Dữ liệu mẫu / output mong đợi
| ... | ... |

### Tiêu chí tự check
- [ ] Compile/chạy OK
- [ ] Đủ requirement roadmap
- [ ] Convention đúng (struct/class, naming, ...)

### Sau khi xong
Paste code hoặc @ file → **REVIEW**. Pass → **SESSION**.
```

---

# Appendix D — Tạo project theo toolchain

**Nguyên tắc bắt buộc khi điền vào output:**
- Dùng đường dẫn đầy đủ từ root working directory — không viết chung chung "trong thư mục projects"
- Nhắc cạm bẫy phổ biến ngay tại bước đó (IDE tự bật setting ngoài ý muốn, version mặc định sai...)
- Kết thúc bằng: "Sau khi tạo xong, mở `[tên file chính]` và bắt đầu với `[điểm xuất phát cụ thể]`"

**Xcode Playground (Swift — bài học ngắn, không cần UI):**
```
1. Mở Xcode
2. File → New → Playground... (⌘⇧N → chọn "Playground" nếu cần)
3. Chọn platform: macOS (dùng iOS chỉ khi bài cần UIKit/SwiftUI views)
4. Đặt tên: [TênBài] — ví dụ: Day3-Collections
5. Save location: [đường dẫn đầy đủ]/projects/[weekN-xxx]/
   (không save vào Desktop — Xcode hay đề xuất vậy)
6. Click Create → xoá code mẫu `//: A Swift Tour`
7. Sau khi tạo xong, mở `Contents.swift` và bắt đầu với `import Foundation`
```

**Xcode App Project (Swift/SwiftUI — bài cần simulator/views):**
```
1. Mở Xcode
2. File → New → Project... (⌘⇧N)
3. Chọn template: iOS → App → Next
4. Điền:
   - Product Name: [TênProject]
   - Team: None (học thì không cần signing)
   - Interface: SwiftUI
   - Language: Swift
   - Bỏ chọn: Include Tests (trừ khi bài có yêu cầu test)
5. Save location: [đường dẫn đầy đủ]/projects/[weekN-xxx]/
6. Bỏ chọn "Create Git repository on my Mac" nếu đang dùng repo chung
7. Click Create → mở `ContentView.swift` để bắt đầu
```

**Python:**
```
1. mkdir -p [đường dẫn đầy đủ]/projects/[phaseN-xxx]/[TênProject]
2. touch [đường dẫn đầy đủ]/projects/[phaseN-xxx]/[TênProject]/main.py
3. code [đường dẫn đầy đủ]/projects/[phaseN-xxx]/[TênProject]/
```

**Node.js / TypeScript:**
```
1. cd [đường dẫn đầy đủ]/projects/[phaseN-xxx]/
2. mkdir [TênProject] && cd [TênProject]
3. npm init -y
4. npm install -D typescript ts-node @types/node   # nếu dùng TypeScript
5. touch index.ts && code .
```

**Kotlin (file đơn):**
```
1. mkdir -p [đường dẫn đầy đủ]/projects/[phaseN-xxx]/[TênProject]
2. touch [đường dẫn đầy đủ]/projects/[phaseN-xxx]/[TênProject]/Main.kt
3. code .
4. Chạy: kotlinc Main.kt -include-runtime -d main.jar && java -jar main.jar
```

**Kotlin Android App (Android Studio):**
```
1. Mở Android Studio → File → New → New Project
2. Chọn template: Empty Activity (Compose) → Next
3. Điền:
   - Name: [TênProject]
   - Package name: com.study.[tenproject]
   - Save location: [đường dẫn đầy đủ]/projects/[weekN-xxx]/[TênProject]
   - Language: Kotlin / Minimum SDK: API 26
4. Finish → đợi Gradle sync → mở `MainActivity.kt`
```

**React Native / Expo:**
```
1. cd [đường dẫn đầy đủ]/projects/[weekN-xxx]/
2. npx create-expo-app [TênProject] --template blank-typescript
3. cd [TênProject] && npx expo start
4. Mở `App.tsx` để bắt đầu
```
