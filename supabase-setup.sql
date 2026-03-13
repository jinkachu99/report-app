-- ============================================
-- Supabase 테이블 생성 SQL
-- SQL Editor에 복사 → Run 클릭
-- ============================================

-- 1) 회사정보 (공급자) - 전체 공유, 1개 행만 유지
create table company (
  id int primary key default 1 check (id = 1),
  company_name text default '',
  registration_number text default '',
  representative text default '',
  company_address text default '',
  business_type text default '',
  phone text default '',
  logo_url text default '',
  stamp_url text default '',
  updated_at timestamptz default now()
);

-- 기본 회사정보 삽입
insert into company (company_name, registration_number, representative, company_address, business_type, phone)
values ('0원누수', '858-18-02343', '최혁진', '부산광역시 해운대구 대천로67번길 12, 4층 401-80A', '건설업 / 배관 및 냉·난방 공사업', '1555-6482');

-- 2) 소견서 문서
create table documents (
  id uuid primary key default gen_random_uuid(),
  title text default '새 소견서',
  manager_name text default '',
  email text default '',
  visit_date text default '',
  manager_phone text default '',
  site_address text default '',
  leak_cause text default '',
  work_items text default '',
  detail_finding text default '',
  note text default '',
  special_note text default '본 소견서는 방문 일자로부터 14일간의 세대내 누수 원인을 입증하는데 유효합니다. 공용부위나 복합누수 원인에 경우 모든 내용을 기입하지 않을 수 있습니다.',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 3) 템플릿
create table templates (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  data jsonb not null default '{}',
  created_at timestamptz default now()
);

-- ============================================
-- RLS (Row Level Security) 정책
-- 같은 서버 사용자끼리 모든 데이터 공유
-- ============================================
alter table company enable row level security;
alter table documents enable row level security;
alter table templates enable row level security;

-- 모든 사용자에게 전체 접근 허용 (anon key 사용)
create policy "공개 읽기" on company for select using (true);
create policy "공개 수정" on company for update using (true);

create policy "공개 읽기" on documents for select using (true);
create policy "공개 생성" on documents for insert with check (true);
create policy "공개 수정" on documents for update using (true);
create policy "공개 삭제" on documents for delete using (true);

create policy "공개 읽기" on templates for select using (true);
create policy "공개 생성" on templates for insert with check (true);
create policy "공개 수정" on templates for update using (true);
create policy "공개 삭제" on templates for delete using (true);
