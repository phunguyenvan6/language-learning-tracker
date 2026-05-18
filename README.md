# SwiftUI Learning — Senior React Native Developer

Lộ trình học SwiftUI được thiết kế cho Senior React Native Developer, học theo hướng mapping từ React Native/TypeScript.

---

## Cấu trúc thư mục

```
SwiftUI/
├── swiftui_learning_roadmap_for_senior_react_native_developer.md   ← Roadmap gốc
├── README.md                                                         ← File này
├── projects/                  ← Code của từng project thực hành
│   ├── week1-swift-foundation/
│   │   └── TransactionManager/
│   ├── week2-swiftui-basics/
│   │   └── EWalletHomeScreen/
│   ├── week3-state-data-flow/
│   │   └── AddTransactionForm/
│   ├── week4-navigation/
│   │   └── TransactionFlow/
│   ├── week5-architecture/
│   │   └── TransactionAppRefactor/
│   ├── week6-networking/
│   │   └── GitHubRepoSearch/
│   ├── week7-persistence/
│   │   └── OfflineTransactionManager/
│   ├── week8-design-system/
│   │   └── EWalletDesignSystem/
│   ├── week9-testing/
│   │   └── TransactionTests/
│   └── week10-production/
│       └── MiniEWalletApp/
└── report/
    ├── agent/                 ← Context files cho AI agent (CHỈ TẠO, KHÔNG SỬA)
    │   └── context_v1_2026-05-18.md
    └── sessions/              ← Report từng buổi học
        └── session_template.md
```

---

## 10 Phases

| # | Tuần | Phase | Project |
|---|---|---|---|
| 1 | Week 1 | Swift Foundation | TransactionManager |
| 2 | Week 2 | SwiftUI Views & Layout | EWalletHomeScreen |
| 3 | Week 3 | State & Data Flow | AddTransactionForm |
| 4 | Week 4 | Navigation & App Structure | TransactionFlow |
| 5 | Week 5 | Architecture | TransactionAppRefactor |
| 6 | Week 6 | Networking | GitHubRepoSearch |
| 7 | Week 7 | Persistence | OfflineTransactionManager |
| 8 | Week 8 | Design System & Advanced UI | EWalletDesignSystem |
| 9 | Week 9 | Testing | TransactionTests |
| 10 | Week 10 | Production Readiness | MiniEWalletApp |

---

## Quy tắc thư mục report/

### report/agent/
- Chứa context files để AI agent hiểu learner profile, tiến độ, và convention
- **Chỉ tạo file mới** — không bao giờ sửa file đã tồn tại
- Khi cần cập nhật: tạo `context_v{n}_{YYYY-MM-DD}.md`, đánh dấu `[[CHANGED]]` tại phần thay đổi

### report/sessions/
- Mỗi buổi học tạo 1 file report mới
- Format tên file: `session_YYYY-MM-DD_phase{N}_day{N}.md`
- Dùng `session_template.md` làm mẫu

---

## Bắt đầu

Đọc roadmap gốc tại [swiftui_learning_roadmap_for_senior_react_native_developer.md](swiftui_learning_roadmap_for_senior_react_native_developer.md), sau đó bắt đầu với **Week 1 — Day 1: Variables, Functions, Structs, Classes**.
